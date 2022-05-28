#!/bin/sh
# vim: set filetype=sh noexpandtab ts=2 sts=2 sw=2 foldmethod=marker:
# vim: set foldmarker=[[[,]]]:

set -e

${HG:-hg} id -i -B | awk 'NR=1 { if (length($2) != 0) { print $2 } else { print substr($1, 1, 9) } }'
