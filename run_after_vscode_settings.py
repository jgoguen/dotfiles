#!/usr/bin/env python3
# vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4 autoindent:
# vim: set foldmarker=[[[,]]] foldmethod=marker foldlevel=0:

import argparse
import json
import os
import sys


dirs = [
    "Code",
    "Code - Insiders",
]

if sys.platform == "darwin":
    cfg_base_dir = os.path.join(os.environ["HOME"], "Library", "Application Support")
else:
    cfg_base_dir = os.environ.get(
        "XDG_CONFIG_HOME",
        os.path.join(os.environ["HOME"], ".config"),
    )


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--dirs",
        nargs="*",
        default=dirs,
        help="VS Code directory names to consider",
    )
    opts = parser.parse_args()

    cfg_files = [
        os.path.join(cfg_base_dir, d, "User", "settings.json") for d in opts.dirs
    ]

    for fname in cfg_files:
        if not os.path.isdir(os.path.dirname(fname)):
            os.makedirs(os.path.dirname(fname), mode=0o0700, exist_ok=True)

        data = {}
        if os.path.exists(fname):
            try:
                with open(fname, "r") as f:
                    data.update(json.load(f))
            except Exception:
                pass

        data.update(
            {
                "breadcrumbs.enabled": True,
                "C_Cpp.default.cStandard": "c11",
                "C_Cpp.default.cppStandard": "c++14",
                "C_Cpp.updateChannel": "Insiders",
                "dev.containers.copyGitConfig": False,
                "diffEditor.ignoreTrimWhitespace": False,
                "editor.acceptSuggestionOnEnter": "off",
                "editor.autoIndent": "advanced",
                "editor.bracketPairColorization.enabled": True,
                "editor.codeLensFontFamily": "JetBrainsMono Nerd Font",
                "editor.copyWithSyntaxHighlighting": False,
                "editor.cursorSurroundingLines": 1,
                "editor.fontFamily": "JetBrainsMono Nerd Font",
                "editor.fontLigatures": "'ss01', 'ss02', 'ss03', 'ss05', 'ss07', 'cv22', 'cv24', 'cv25', 'cv26', 'cv32'",
                "editor.fontSize": 13,
                "editor.formatOnPaste": True,
                "editor.formatOnSave": True,
                "editor.formatOnSaveMode": "modificationsIfAvailable",
                "editor.guides.bracketPairs": True,
                "editor.indentSize": "tabSize",
                "editor.inlayHints.fontFamily": "JetBrainsMono Nerd Font",
                "editor.insertSpaces": False,
                "editor.linkedEditing": True,
                "editor.minimap.enabled": False,
                "editor.multiCursorModifier": "ctrlCmd",
                "editor.multiCursorPaste": "full",
                "editor.quickSuggestions": {
                    "comments": "on",
                    "other": "on",
                    "strings": "on",
                },
                "editor.renderControlCharacters": True,
                "editor.renderFinalNewline": "off",
                "editor.renderWhitespace": "boundary",
                "editor.rulers": [80],
                "editor.scrollBeyondLastLine": False,
                "editor.showFoldingControls": "always",
                "editor.tabCompletion": "on",
                "editor.tabSize": 2,
                "editor.unicodeHighlight.includeComments": True,
                "editor.wordWrap": "bounded",
                "editor.wordWrapColumn": 80,
                "explorer.openEditors.visible": 1,
                "extensions.ignoreRecommendations": True,
                "files.associations": {"*.cgi": "perl"},
                "files.autoSave": "onFocusChange",
                "files.eol": "\n",
                "files.insertFinalNewline": True,
                "files.readonlyFromPermissions": True,
                "files.trimFinalNewlines": True,
                "files.trimTrailingWhitespace": True,
                "files.watcherExclude": {
                    "**/.git/objects/**": True,
                    "**/.git/subtree-cache/**": True,
                    "**/.hg/**": True,
                    "**/node_modules/**": True,
                },
                "git.allowForcePush": True,
                "git.alwaysSignOff": True,
                "git.autoStash": True,
                "git.autofetch": True,
                "git.defaultCloneDirectory": "",
                "git.enableCommitSigning": True,
                "git.enableSmartCommit": True,
                "git.fetchOnPull": True,
                "git.mergeEditor": True,
                "github.gitProtocol": "ssh",
                "go.autocompleteUnimportedPackages": True,
                "go.enableCodeLens": {"references": False, "runtest": True},
                "go.formatTool": "goimports",
                "go.gotoSymbol.includeGoroot": True,
                "go.gotoSymbol.includeImports": True,
                "go.inferGopath": False,
                "go.installDependenciesWhenBuilding": True,
                "go.lintOnSave": "workspace",
                "go.liveErrors": {"enabled": True, "delay": 500},
                "go.toolsManagement.autoUpdate": True,
                "go.useLanguageServer": True,
                "keyboard.dispatch": "keyCode",
                "markdown.extension.orderedList.marker": "one",
                "markdown.preview.fontFamily": "JetBrainsMono Nerd Font",
                "markdown.preview.linkify": True,
                "markdown.preview.openMarkdownLinks": "inEditor",
                "markdownlint.run": "onSave",
                "merge-conflict.autoNavigateNextConflict.enabled": True,
                "python.analysis.autoImportCompletions": True,
                "python.analysis.completeFunctionParens": True,
                "python.analysis.importFormat": "relative",
                "python.analysis.typeCheckingMode": "strict",
                "python.autoComplete.addBrackets": True,
                "python.formatting.blackPath": "/usr/local/bin/black"
                if sys.platform == "darwin"
                else "/usr/bin/black",
                "python.formatting.provider": "black",
                "python.insidersChannel": "weekly",
                "python.linting.flake8Args": ["--max-line-length=88"],
                "python.linting.flake8Enabled": True,
                "python.linting.flake8Path": "/usr/local/bin/flake8"
                if sys.platform == "darwin"
                else "/usr/bin/flake8-3",
                "python.linting.mypyEnabled": False,
                "python.linting.pep8Enabled": False,
                "python.linting.pycodestyleEnabled": False,
                "python.linting.pylamaEnabled": False,
                "python.linting.pylintEnabled": False,
                "python.pythonPath": "/usr/local/bin/python3"
                if sys.platform == "darwin"
                else "/usr/bin/python3",
                "redhat.telemetry.enabled": False,
                "remote.SSH.enableX11Forwarding": False,
                "remote.SSH.localServerDownload": "off",
                "remote.SSH.lockfilesInTmp": True,
                "remote.SSH.remoteServerListenOnSocket": True,
                "remote.SSH.showLoginTerminal": True,
                "scm.alwaysShowRepositories": True,
                "scss.format.spaceAroundSelectorSeparator": True,
                "search.showLineNumbers": True,
                "search.smartCase": True,
                "shellcheck.customArgs": ["-x"],
                "shellcheck.run": "onSave",
                "telemetry.telemetryLevel": "off",
                "terminal.integrated.copyOnSelection": True,
                "terminal.integrated.fontFamily": "JetBrainsMono Nerd Font",
                "terminal.integrated.fontSize": 15,
                "terminal.integrated.lineHeight": 1.1,
                "vsicons.dontShowNewVersionMessage": True,
                "window.autoDetectColorScheme": True,
                "window.newWindowDimensions": "inherit",
                "window.restoreWindows": "all",
                "window.zoomLevel": 0,
                "workbench.editor.enablePreview": False,
                "workbench.editor.enablePreviewFromQuickOpen": False,
                "workbench.editor.highlightModifiedTabs": True,
                "workbench.editor.sharedViewState": True,
                "workbench.fontAliasing": "auto",
                "workbench.iconTheme": "material-icon-theme",
                "workbench.list.horizontalScrolling": True,
                "workbench.list.openMode": "doubleClick",
                "workbench.preferredDarkColorTheme": "Everblush",
                "workbench.quickOpen.closeOnFocusLost": False,
                "workbench.sideBar.location": "left",
                "workbench.startupEditor": "none",
                "workbench.tree.indent": 4,
                "yaml.customTags": [
                    "!encrypted/pkcs1-oaep scalar",
                    "!include_dir_named mapping",
                    "!lambda scalar",
                    "!secret scalar",
                    "!vault scalar",
                ],
                "yaml.format.printWidth": 120,
                "yaml.format.proseWrap": "always",
                "yaml.format.singleQuote": True,
                "yaml.schemaStore.enable": True,
                "yaml.schemas": {
                    "https://json.schemastore.org/github-workflow": "/.github/workflows/*.y{a,}ml"
                },
                "zenMode.hideLineNumbers": False,
                "zenMode.hideStatusBar": False,
                "zenMode.hideTabs": False,
                "zenMode.restore": False,
                "[home-assistant]": {
                    "editor.insertSpaces": True,
                    "editor.quickSuggestions": {
                        "comments": False,
                        "other": True,
                        "strings": True,
                    },
                    "editor.rulers": [120],
                    "editor.wordWrapColumn": 120,
                    "files.insertFinalNewline": False,
                },
                "[markdown]": {"editor.insertSpaces": False},
                "[python]": {
                    "editor.formatOnPaste": False,
                    "editor.insertSpaces": True,
                    "editor.rulers": [88],
                    "editor.tabSize": 4,
                    "editor.wordWrapColumn": 88,
                },
                "[yaml]": {
                    "editor.insertSpaces": True,
                    "editor.rulers": [120],
                    "files.insertFinalNewline": False,
                },
            }
        )

        gopath_var = data.get("go.gopath", "").split(":")
        gopath_local = [
            os.path.expanduser("~/.local/share/gopaths"),
            os.path.expanduser("~/Library/Application Support/golang"),
        ]
        gopath = []
        for d in gopath_var + gopath_local:
            if d not in gopath and os.path.isdir(d):
                gopath.append(d)
        if len(gopath) > 0:
            data["go.gopath"] = ":".join(gopath)

        markdown_font = [
            f.strip() for f in data.get("markdown.preview.fontFamily", "").split(",")
        ]
        if "JetBrainsMono Nerd Font" not in markdown_font:
            markdown_font.insert(0, "JetBrainsMono Nerd Font")
        data["markdown.preview.fontFamily"] = ", ".join(markdown_font)

        python_complete_paths = [
            f.strip() for f in data.get("python.autoComplete.extraPaths", "").split(",")
        ]
        calibre_dir = os.path.expanduser("~/Code/calibre")
        if os.path.isdir(calibre_dir) and calibre_dir not in python_complete_paths:
            python_complete_paths.append(calibre_dir)
        data["python.autoComplete.extraPaths"] = ",".join(python_complete_paths)

        with open(fname, "w") as f:
            json.dump(data, f, indent=4)

    return 0


if __name__ == "__main__":
    sys.exit(main())
