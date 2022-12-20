#!/bin/sh
# vim: set filetype=sh noexpandtab ts=2 sts=2 sw=2:

set -eux

if [ -f "${HOME}/.tmux.conf" ]; then
	if [ -f "${XDG_CONFIG_HOME:-${HOME}/.config}/tmux/tmux.conf" ]; then
		printf '%s already exists, please merge %s into it\n' "${XDG_CONFIG_HOME:-${HOME}/.config}/tmux/tmux.conf" "${HOME}/.tmux.conf"
	else
		test -d "${XDG_CONFIG_HOME:-${HOME}/.config}/tmux" || mkdir -p "${XDG_CONFIG_HOME:-${HOME}/.config}/tmux"
		mv "${HOME}/.tmux.conf" "${XDG_CONFIG_HOME:-${HOME}/.config}/tmux/tmux.conf"
	fi
fi
