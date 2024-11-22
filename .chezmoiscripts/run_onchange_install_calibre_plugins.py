#!/usr/bin/env python3
# vim: set filetype=python syntax=python:

import bz2
import json
import os
import platform
import shutil
import ssl
import subprocess
import sys

from tempfile import NamedTemporaryFile
from urllib.request import urlopen


if platform.system() == "Darwin":
    calibre_base = os.path.join("/Applications", "calibre.app", "Contents", "MacOS")
    calibre_customize_bin = os.path.join(calibre_base, "calibre-customize")
    calibre_debug_bin = os.path.join(calibre_base, "calibre-debug")
else:
    calibre_customize_bin = shutil.which("calibre-customize")
    calibre_debug_bin = shutil.which("calibre-debug")

BASE_URL = "https://code.calibre-ebook.com/plugins/"
PLUGIN_INDEX = f"{BASE_URL}/plugins.json.bz2"
PLUGIN_KEYS = {
    "Barnes & Noble",
    "DeACSM",
    "EpubMerge",
    "EpubSplit",
    "FanFicFare",
    "Fantastic Fiction Adults",
    "Fantastic Fiction",
    "Generate Cover",
    "Goodreads",
    "KFX Input",
    "KFX Output",
    "KePub Input",
    "KePub Metadata Reader",
    "KePub Metadata Writer",
    "KePub Output",
    "Kindle Collections",
    "Kindle High-res Covers",
    "Kobo Books",
    "Kobo Utilities",
    "KoboTouchExtended",
    "Overdrive Link",
}


def main() -> int:
    if (
        calibre_customize_bin is None
        or calibre_debug_bin is None
        or not os.path.isfile(calibre_customize_bin)
        or not os.path.isfile(calibre_debug_bin)
    ):
        print("Could not find calibre-customize or calibre-debug")
        return 1

    resources_proc = subprocess.run(
        [calibre_debug_bin, "-c", "print(sys.resources_location)"],
        capture_output=True,
        check=True,
        encoding="UTF-8",
    )
    cafile = os.path.join(resources_proc.stdout.strip(), "calibre-ebook-root-CA.crt")

    ctx = ssl.create_default_context(cafile=cafile)

    plugins: dict[str, dict[str, str]] = {}
    with urlopen(PLUGIN_INDEX, context=ctx) as resp:
        plugins = json.loads(bz2.decompress(resp.read()))

    for plugin in PLUGIN_KEYS:
        if plugin not in plugins:
            raise Exception(plugin)
        plugin_remote_file = plugins.get(plugin, {}).get("original_url", None)
        if plugin_remote_file is None:
            continue

        print(f"Installing plugin: {plugin}")
        with urlopen(plugin_remote_file) as resp:
            with NamedTemporaryFile() as tmp_file:
                shutil.copyfileobj(resp, tmp_file)
                proc = subprocess.run(
                    [calibre_customize_bin, "-a", tmp_file.name],
                    capture_output=True,
                    encoding="UTF-8",
                )
                if proc.returncode != 0:
                    print(
                        f"Failed to install plugin from {plugin_remote_file}:\n{proc.stderr}"
                    )

    return 0


if __name__ == "__main__":
    sys.exit(main())
