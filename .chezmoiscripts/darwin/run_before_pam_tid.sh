#!/bin/sh
# vim: set filetype=sh:

set -eu

# shellcheck source=../../helpers.sh
. "${HOME}/.local/share/chezmoi/helpers.sh"

if ! grep -q 'pam_tid\.so' /etc/pam.d/sudo; then
	log "Enabling pam_tid.so for sudo" "INFO"
	# Insert on the second line because the first line on macOS is a comment
	sudo sed -i '' '2i\
auth       sufficient     pam_tid.so\
' /etc/pam.d/sudo
fi
