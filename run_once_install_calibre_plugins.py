#!/usr/bin/env python3
# vim: set expandtab shiftwidth=4 tabstop=4 softtabstop=4 foldmethod=indent:
# vim: set syntax=python:

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

    ctx = ssl.SSLContext()
    ctx.load_verify_locations(cafile)

    plugins = {}
    with urlopen(PLUGIN_INDEX, context=ctx) as resp:
        plugins = json.loads(bz2.decompress(resp.read()))

    for plugin in PLUGIN_KEYS:
        if plugin not in plugins:
            raise Exception(plugin)
        plugin_remote_file = plugins.get(plugin, {}).get("file", None)
        if plugin_remote_file is None:
            continue

        print(f"Installing plugin: {plugin}")
        plugin_url = f"{BASE_URL}/{plugin_remote_file}"
        with urlopen(plugin_url, context=ctx) as resp:
            with NamedTemporaryFile() as tmp_file:
                shutil.copyfileobj(resp, tmp_file)
                proc = subprocess.run(
                    [CALIBRE_CUSTOMIZE_BIN, "-a", tmp_file.name],
                    capture_output=True,
                    encoding="UTF-8",
                )
                if proc.returncode != 0:
                    print(f"Failed: {proc.stderr}")

    return 0


if __name__ == "__main__":
    sys.exit(main())
