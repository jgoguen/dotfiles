#!/bin/sh

set -x

if ! grep -q 'pam_tid\.so' /etc/pam.d/sudo; then
	# Insert on the second line because the first line on macOS is a comment
	sudo sed -i '' '2i\
auth       sufficient     pam_tid.so\
' /etc/pam.d/sudo
fi
