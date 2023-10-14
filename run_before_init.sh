#!/bin/sh
# vim: set filetype=sh noexpandtab ts=2 sts=2 sw=2:

set -eu

. "${HOME}/.local/share/chezmoi/helpers.sh"

if [ ! -d "${XDG_CONFIG_HOME:-${HOME}/.config}/tmux/plugins/tpm" ]; then
	log "Installing Tmux Plugins Manager" "INFO"
	git clone https://github.com/tmux-plugins/tpm "${XDG_CONFIG_HOME:-${HOME}/.config}/tmux/plugins/tpm"
fi
