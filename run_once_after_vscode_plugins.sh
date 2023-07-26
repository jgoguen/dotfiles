#!/bin/sh
# vim: set noexpandtab tabstop=2 shiftwidth=2 autoindent:
# vim: set foldmarker=[[[,]]] foldmethod=marker foldlevel=0:

set -ux

CODE_BIN="$(command -v code)"
CODE_INSIDERS_BIN="$(command -v code-insiders)"
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

if [ -n "${CODE_BIN}" ]; then
	for ext in ${EXTENSIONS}; do
		${CODE_BIN} --install-extension "${ext}" --force
	done
fi

if [ -n "${CODE_INSIDERS_BIN}" ]; then
	for ext in ${EXTENSIONS}; do
		${CODE_INSIDERS_BIN} --install-extension "${ext}" --force
	done
fi
