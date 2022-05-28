#!/bin/sh
# vim: set filetype=sh noexpandtab ts=2 sts=2 sw=2 foldmethod=marker:
# vim: set foldmarker=[[[,]]]:

set -e

HG="${HG:-hg}"
COMMIT_ID="$(${HG} id -i)"

${HG} bookmarks --list-subscriptions | awk '{ map[$2] = $1; } END { if ("'"$COMMIT_ID"'" in map) { print "(" map["'"$COMMIT_ID"'"] ")"; } }'
