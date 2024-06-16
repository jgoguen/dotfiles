#!/bin/sh
# vim: set filetype=sh noexpandtab ts=2 sts=2 sw=2:

set -e

if [ -f "${HOME}/.zlogin" ]; then
	rm -f "${HOME}/.zlogin"
fi
