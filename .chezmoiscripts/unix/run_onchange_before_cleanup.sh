#!/bin/sh
# vim: set filetype=sh:

set -e

if [ -f "${HOME}/.zlogin" ]; then
	rm -f "${HOME}/.zlogin"
fi
