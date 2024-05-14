#!/usr/bin/env python3
# vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4 autoindent:
# vim: set foldmarker=[[[,]]] foldmethod=marker foldlevel=0:

import json
import logging
import os
import shutil
import subprocess
import sys


OP_BIN = shutil.which("op")


def main() -> int:
    if not os.path.isfile(OP_BIN):
        print(f"{OP_BIN} does not exist, cannot gather files", file=sys.stderr)
        return 1

    logging.debug("Using op location: %s", OP_BIN)

    proc = subprocess.run(
        [OP_BIN, "document", "list", "--format", "json"],
        capture_output=True,
        check=True,
    )

    op_docs = json.loads(proc.stdout)
    files = {}
    logging.debug("Loaded 1Password documents")

    for op_doc in op_docs:
        for tag in op_doc.get("tags", []):
            if tag.startswith("chezmoi_file:"):
                files[op_doc["id"]] = tag.split(":", 2)[1]
                logging.debug("Found file to install at %s", files[op_doc["id"]])
                break

    excludes = []
    chezmoi_proc = subprocess.run(
        ["chezmoi", "source-path"], capture_output=True, check=True
    )
    source_base = chezmoi_proc.stdout.decode("UTF-8").strip()
    logging.debug("Chezmoi source path: %s", source_base)

    for uuid in files:
        dirname = os.path.expanduser(os.path.dirname(files[uuid]))
        basename = os.path.basename(files[uuid])
        proc = subprocess.run(
            ["chezmoi", "source-path", dirname], capture_output=True, check=True
        )
        source_dir = proc.stdout.decode("UTF-8").strip()
        source_path = os.path.join(source_dir, basename)

        logging.debug(
            "Installing file %s to Chezmoi source path %s",
            basename,
            source_path,
        )

        if os.path.isfile(source_path):
            os.unlink(source_path)
        subprocess.run(
            [OP_BIN, "document", "get", uuid, "--output", source_path],
            capture_output=True,
            check=True,
        )
        excludes.append(os.path.relpath(source_path, source_base))

    with open(os.path.join(source_base, ".git", "info", "exclude"), "w") as f:
        logging.debug("Writing files to git excludes: %s", excludes)
        f.write("\n".join(excludes))

    return 0


if __name__ == "__main__":
    logging.basicConfig(
        level=logging.INFO if os.environ.get("DEBUG") is None else logging.DEBUG,
        style="{",
        format="{asctime} [{levelname}] [{filename}:{lineno}] {message}",
    )
    sys.exit(main())
