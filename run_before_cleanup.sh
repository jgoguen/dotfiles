#!/bin/sh
# vim: set filetype=sh noexpandtab ts=2 sts=2 sw=2:

set -eu

. "${HOME}/.local/share/chezmoi/helpers.sh"

if [ -f "${HOME}/.tmux.conf" ]; then
	if [ -f "${XDG_CONFIG_HOME:-${HOME}/.config}/tmux/tmux.conf" ]; then
		log "${XDG_CONFIG_HOME:-${HOME}/.config}/tmux/tmux.conf already exists, please merge ${HOME}/.tmux.conf into it" "WARN"
	else
		log "Moving ${HOME}/.tmux.conf to ${XDG_CONFIG_HOME:-${HOME}/.config}/tmux/tmux.conf" "INFO"
		test -d "${XDG_CONFIG_HOME:-${HOME}/.config}/tmux" || mkdir -p "${XDG_CONFIG_HOME:-${HOME}/.config}/tmux"
		mv "${HOME}/.tmux.conf" "${XDG_CONFIG_HOME:-${HOME}/.config}/tmux/tmux.conf"
	fi
fi
