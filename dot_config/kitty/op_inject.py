# ~/.config/kitty/op_inject.py
import json
import os
import subprocess
from dataclasses import dataclass

from kittens.tui.handler import kitten_ui
from kitty.boss import Boss

CONTEXT_LINES = 10
PATH_CANDIDATES = [
    "/opt/homebrew/bin",
    "/usr/local/sbin",
    "/usr/local/bin",
    "/usr/sbin",
    "/usr/bin",
    "/sbin",
    "/bin",
    os.path.expanduser("~/.local/bin"),
    os.path.expanduser("~/.cargo/bin"),
]


@dataclass(slots=True, kw_only=True)
class OpVault:
    id: str
    name: str


@dataclass(slots=True, kw_only=True)
class OpItem:
    id: str
    title: str
    favorite: bool
    version: int
    vault: OpVault
    category: str
    last_edited_by: str
    created_at: str
    updated_at: str
    additional_information: str

    @staticmethod
    def from_json(data: str) -> list[OpItem]:
        obj = json.loads(data)
        if not isinstance(obj, list):
            raise TypeError(f"unexpected item list format: {obj}")
        items: list[OpItem] = []

        for item in obj:
            vault = item.get("vault", {})
            if not isinstance(vault, dict):
                raise TypeError(f"unexpected vault format: {vault}")
            items.append(OpItem(
                id=item.get("id", ""),
                title=item.get("title", ""),
                favorite=item.get("favorite", False),
                version=item.get("version", 0),
                vault=OpVault(**vault),
                category=item.get("category", ""),
                last_edited_by=item.get("last_edited_by", ""),
                created_at=item.get("created_at", ""),
                updated_at=item.get("updated_at", ""),
                additional_information=item.get("additional_information", ""),
            ))

        return items


@dataclass(slots=True, kw_only=True)
class KittyProcessInfo:
    at_prompt: bool
    cmdline: list[str]
    cwd: str
    foreground_processes: list[KittyProcessInfo]
    pid: int

    @staticmethod
    def from_json(data: str) -> KittyProcessInfo:
        obj = json.loads(data)
        return KittyProcessInfo(
            at_prompt=obj.get("at_prompt", False),
            cmdline=obj.get("cmdline", []),
            cwd=obj.get("cwd", ""),
            foreground_processes=[
                KittyProcessInfo.from_json(json.dumps(fp))
                for fp in obj.get("foreground_processes", [])
            ],
            pid=obj.get("pid", 0),
        )


def list_server_items() -> list[OpItem]:
    try:
        proc = subprocess.run(
            ["op", "item", "list", "--categories", "Server", "--format", "json"],
            capture_output=True,
            text=True,
            check=True,
        )
        return OpItem.from_json(proc.stdout)
    except TypeError as te:
        print(f"[error] failed to parse items: {te}")
        return []
    except subprocess.CalledProcessError as cpe:
        print(f"[error] failed to list items: {cpe}")
        return []


def get_screen_text() -> str:
    get_text_ctrl = main.remote_control(
        ["get-text", "--match", "state:overlay_parent", "--extent", "screen"],
        capture_output=True,
    )
    if get_text_ctrl.returncode != 0:
        print("[error] get-text failed:")
        print(get_text_ctrl.stderr)
        input("Press Enter to close...")
        return ""

    # This will be a str but the type checker has problems with the function added by
    # the kitty `kitten_ui` decorator, so we enforce the type.
    screen_text = str(
        get_text_ctrl.stdout
        if isinstance(get_text_ctrl.stdout, str)
        else get_text_ctrl.stdout.decode()
    )

    return screen_text


@kitten_ui(allow_remote_control=True)
def main(args: list[str]) -> str:
    debug = "--debug" in args
    live = "--live" in args  # only matters combined with --debug
    reveal = "--reveal" in args  # only matters combined with --debug

    # Kittens don't include the full path, but loading from the shell could introduce
    # too much delay. Run through a set of common paths here and reconstruct `$PATH`
    # based on what exists. We strictly append to path here and preserve the existing
    # path by taking advantage of the fact that dict keys retain insertion order.
    new_path = {
        p: None
        for p in os.environ.get("PATH", "").split(os.pathsep)
        if os.path.exists(p)
    }
    for p in PATH_CANDIDATES:
        if os.path.exists(p):
            new_path[p] = None
    os.environ["PATH"] = os.pathsep.join(new_path.keys())

    get_text_ctrl = main.remote_control(
        ["get-text", "--match", "state:overlay_parent", "--extent", "screen"],
        capture_output=True,
    )
    if get_text_ctrl.returncode != 0:
        print("[error] get-text failed:")
        print(get_text_ctrl.stderr)
        input("Press Enter to close...")
        return ""

    screen_text = (
        get_text_ctrl.stdout
        if isinstance(get_text_ctrl.stdout, str)
        else get_text_ctrl.stdout.decode()
    )

    # Try to determine what kind of field we need
    field = ""
    for line in screen_text.splitlines()[-CONTEXT_LINES:]:
        line = line.strip().lower()

        if line.endswith(" verification code:"):
            field = "o"
            break
        if "password:" in line or line.startswith("[sudo] password for "):
            field = "p"
            break

    item_id = ""
    op_server_items = list_server_items()
    if len(op_server_items) == 1:
        item_id = op_server_items[0].id
    elif len(op_server_items) > 1:
        # First let's see if we're running SSH and can match by hostname
        kitty_proc_info = main.remote_control(
            ["ls", "--match", "state:overlay_parent"],
            capture_output=True,
        )
        if kitty_proc_info.returncode == 0:
            try:
                proc_info = KittyProcessInfo.from_json(
                    kitty_proc_info.stdout
                    if isinstance(kitty_proc_info.stdout, str)
                    else kitty_proc_info.stdout.decode()
                )
                if len(proc_info.foreground_processes) > 0:
                    for proc in proc_info.foreground_processes:
                        if not proc.cmdline or proc.cmdline[0] != "ssh":
                            continue

                        # Typically the SSH target, could be the hostname, user@hostname,
                        # or a Host entry from ssh_config.
                        ssh_target = proc_info.cmdline[1].split("@")[-1]
                        for it in op_server_items:
                            if it.title.lower() == ssh_target.lower():
                                item_id = it.id
                                break
                        if item_id:
                            break
            except json.JSONDecodeError as e:
                print(f"[error] failed to parse process info: {e}")

        # Let's just ask
        if not item_id:
            for i, it in enumerate(op_server_items):
                print(f"[{i}] {it.title}")
            choice = input("Select item to use: ").strip()
            try:
                item_id = op_server_items[int(choice) - 1].id
            except ValueError, IndexError:
                print("[error] invalid selection")
                input("\n[error] Press Enter to close (nothing will be pasted)...")
                return ""
    if not item_id:
        print("[error] no items found in 1Password vault")
        input("\n[error] Press Enter to close (nothing will be pasted)...")
        return ""

    if not field:
        field = input("Field ([p]assword / [o]tp): ").strip().lower()
    if field not in ("p", "o"):
        print("[error] invalid field choice")
        input("\n[error] Press Enter to close (nothing will be pasted)...")
        return ""
    cmd = ["op", "item", "get", item_id]
    cmd += ["--otp"] if field == "o" else ["--fields", "password", "--reveal"]

    if debug and not live:
        print(f"[debug] would run: {' '.join(cmd)}")
        input(
            "\n[debug] dry run only, nothing fetched or pasted. Press Enter to close..."
        )
        return ""

    proc = subprocess.run(cmd, capture_output=True, text=True, check=True)
    secret = proc.stdout.strip()

    if not secret:
        print(
            f"[error] no secret returned, got return:\ncode: {proc.returncode}\nstderr: {proc.stderr}\nstdout: {proc.stdout}"
        )
        input("\n[error] Press Enter to close (nothing will be pasted)...")
        return ""

    if debug:
        print(
            f"[debug] secret value: {secret}"
            if reveal
            else f"[debug] secret retrieved: {len(secret)} chars, starts with '{secret[0]}'"
        )
        input("\n[debug] Press Enter to close (nothing will be pasted)...")
        return ""

    return secret


def handle_result(
    _args: list[str], answer: str, target_window_id: int, boss: Boss
) -> None:
    w = boss.window_id_map.get(target_window_id)
    if w is not None and answer:
        w.paste_text(answer)
