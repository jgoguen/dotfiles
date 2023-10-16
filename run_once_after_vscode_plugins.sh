#!/bin/sh
# vim: set noexpandtab tabstop=2 shiftwidth=2 autoindent:
# vim: set foldmarker=[[[,]]] foldmethod=marker foldlevel=0:

set -eu

. "${HOME}/.local/share/chezmoi/helpers.sh"

EXTENSIONS="tamasfe.even-better-toml
	chrislajoie.vscode-modelines
	coolbear.systemd-unit-file DavidAnson.vscode-markdownlint
	esphome.esphome-vscode
	formulahendry.auto-close-tag
	GitHub.vscode-pull-request-github golang.go
	mechatroner.rainbow-csv ms-python.python
	PKief.material-icon-theme redhat.vscode-yaml
	RoscoP.ActiveFileInStatusBar stkb.rewrap timonwong.shellcheck
	yzhang.markdown-all-in-one"

if command -v code; then
	for ext in ${EXTENSIONS}; do
		log "Installing VS Code extension: ${ext}" "INFO"
		code --install-extension "${ext}" --force
	done
fi

if command -v code-insiders; then
	for ext in ${EXTENSIONS}; do
		log "Installing VS Code Insiders extension: ${ext}" "INFO"
		code-insiders --install-extension "${ext}" --force
	done
fi
