#!/bin/sh
# vim: set filetype=sh noexpandtab ts=2 sts=2 sw=2 foldmethod=marker:
# vim: set foldmarker=[[[,]]]:

set -e

HG="${HG:-hg}"
HG_ROOT="$(${HG} root 2>/dev/null)"
HG_SHAREDROOT=''

if [ -z "${HG_ROOT}" ]; then
	return $?
else
	HG_ROOT="${HG_ROOT}/.hg"
fi

if [ -f "${HG_ROOT}/sharedpath" ]; then
	HG_SHAREDROOT="$(cat "${HG_ROOT}/sharedpath")"
fi

if [ -f "${HG_ROOT}/bisect.state" ]; then
	printf 'BISECT'
elif [ -f "${HG_ROOT}/histedit-state" ]; then
	printf 'HISTEDIT'
elif [ -f "${HG_ROOT}/graftstate" ]; then
	printf 'GRAFT'
elif [ -f "${HG_ROOT}/unshelverebasestate" ]; then
	printf 'UNSHELVE'
elif [ -f "${HG_ROOT}/rebasestate" ]; then
	printf 'REBASE'
elif [ -d "${HG_ROOT}/merge" ]; then
	printf 'MERGE'
elif [ -L "${HG_ROOT}/store/lock" ]; then
	printf 'STORE-LOCKED'
elif [ -L "${HG_ROOT}/wlock" ]; then
	printf 'WDIR-LOCKED'
elif [ -z "${HG_SHAREDROOT}" ]; then
	if [ -f "${HG_SHAREDROOT}/bisect.state" ]; then
		printf 'BISECT'
	elif [ -f "${HG_SHAREDROOT}/histedit-state" ]; then
		printf 'HISTEDIT'
	elif [ -f "${HG_SHAREDROOT}/graftstate" ]; then
		printf 'GRAFT'
	elif [ -f "${HG_SHAREDROOT}/unshelverebasestate" ]; then
		printf 'UNSHELVE'
	elif [ -f "${HG_SHAREDROOT}/rebasestate" ]; then
		printf 'REBASE'
	elif [ -d "${HG_SHAREDROOT}/merge" ]; then
		printf 'MERGE'
	elif [ -L "${HG_SHAREDROOT}/store/lock" ]; then
		printf 'STORE-LOCKED'
	elif [ -L "${HG_SHAREDROOT}/wlock" ]; then
		printf 'WDIR-LOCKED'
	fi
fi
