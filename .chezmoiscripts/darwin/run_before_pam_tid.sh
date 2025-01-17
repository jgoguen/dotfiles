#!/bin/sh
# vim: set filetype=sh:

set -eu

# shellcheck source=../../helpers.sh
. "${HOME}/.local/share/chezmoi/helpers.sh"

if [ -f /etc/pam.d/sudo_local ]; then
	if ! grep -Eq '^auth\s+sufficient\s+pam_tid\.so$' /etc/pam.d/sudo_local; then
		log "Enabling pam_tid.so for sudo" "INFO"
		# Insert on the second line because the first line on macOS is a comment
		sudo perl -i -pe 's/^#auth\s+sufficient\s+pam_tid\.so$/auth sufficient pam_tid.so/' /etc/pam.d/sudo_local
	fi
else
	log "Creating /etc/pam.d/sudo_local for pam_tid.so" "INFO"
	printf 'auth sufficient pam_tid.so\n' | sudo tee -a /etc/pam.d/sudo_local
fi

# Check for pam_watchid
if [ ! -d /usr/local/lib/pam ] || [ ! -f /usr/local/lib/pam/pam_watchid.so* ]; then
	log "Cloning and installing pam_watchid for sudo_local" "INFO"
	gitroot="$(mktemp --tmpdir -d)"
	git clone https://github.com/Logicer16/pam-watchid.git "${gitroot}"
	cd "${gitroot}"
	make install
	printf 'auth sufficient pam_watchid.so\n' | sudo tee -a /etc/pam.d/sudo_local
fi
