#!/bin/sh
# vim: set noexpandtab tabstop=2 shiftwidth=2 autoindent:
# vim: set foldmarker=[[[,]]] foldmethod=marker foldlevel=0:

set -eu

. "${HOME}/.local/share/chezmoi/helpers.sh"

EXTENSIONS="chrislajoie.vscode-modelines
	coolbear.systemd-unit-file
	DavidAnson.vscode-markdownlint
	EditorConfig.EditorConfig
	esphome.esphome-vscode
	formulahendry.auto-close-tag
	GitHub.vscode-pull-request-github
	golang.go
	mechatroner.rainbow-csv
	ms-azuretools.vscode-docker
	ms-python.black-formatter
	ms-python.python
	ms-python.vscode-pylance
	ms-vscode-remote.remote-containers
	ms-vscode-remote.remote-ssh
	PKief.material-icon-theme
	redhat.vscode-yaml
	tamasfe.even-better-toml
	timonwong.shellcheck
	yzhang.markdown-all-in-one"

if command -v code >/dev/null 2>&1; then
	for ext in ${EXTENSIONS}; do
		log "Installing VS Code extension: ${ext}" "INFO"
		code --install-extension "${ext}" --force
	done
fi

if command -v code-insiders >/dev/null 2>&1; then
	for ext in ${EXTENSIONS}; do
		log "Installing VS Code Insiders extension: ${ext}" "INFO"
		code-insiders --install-extension "${ext}" --force
	done
fi
