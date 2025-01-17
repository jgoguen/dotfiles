#!/bin/sh
# vim: set filetype=sh:

set -eu

# shellcheck source=../../helpers.sh
. "${HOME}/.local/share/chezmoi/helpers.sh"

if [ ! -d /usr/local/lib/pam ] || [ ! -f /usr/local/lib/pam/pam_watchid.so* ]; then
	log "Cloning and installing pam_watchid for sudo_local" "INFO"
	gitroot="$(mktemp --tmpdir -d)"
	git clone https://github.com/Logicer16/pam-watchid.git "${gitroot}"
	cd "${gitroot}"
	make install
	cd -
	rm -rf "${gitroot}"
fi
