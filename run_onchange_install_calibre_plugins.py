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
    CALIBRE_BASE = os.path.join("/Applications", "calibre.app", "Contents", "MacOS")
    CALIBRE_CUSTOMIZE_BIN = os.path.join(CALIBRE_BASE, "calibre-customize")
    CALIBRE_DEBUG_BIN = os.path.join(CALIBRE_BASE, "calibre-debug")
else:
    CALIBRE_CUSTOMIZE_BIN = shutil.which("calibre-customize")
    CALIBRE_DEBUG_BIN = shutil.which("calibre-debug")
if (
    CALIBRE_CUSTOMIZE_BIN is None
    or CALIBRE_DEBUG_BIN is None
    or not os.path.isfile(CALIBRE_CUSTOMIZE_BIN)
    or not os.path.isfile(CALIBRE_DEBUG_BIN)
):
    sys.exit(0)

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
    resources_proc = subprocess.run(
        [CALIBRE_DEBUG_BIN, "-c", "print(sys.resources_location)"],
        capture_output=True,
        check=True,
        encoding="UTF-8",
    )
    cafile = os.path.join(resources_proc.stdout.strip(), "calibre-ebook-root-CA.crt")

    ctx = ssl.create_default_context(cafile=cafile)

    plugins = {}
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
                    [CALIBRE_CUSTOMIZE_BIN, "-a", tmp_file.name],
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
