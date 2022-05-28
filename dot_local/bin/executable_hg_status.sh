# vim: set filetype=sh noexpandtab ts=2 sts=2 sw=2 foldmethod=marker:
# vim: set foldmarker=[[[,]]]:

set -e

HG="${HG:-hg}"
HG_STATUS=''

HG_STATUS_SUMMARY="$(timeout 1 ${HG} status 2>/dev/null  | cut -c 1)"

if [ -n "${HG_STATUS_SUMMARY}" ]; then
	if [[ "${HG_STATUS_SUMMARY}" =~ .*M.* ]]; then
		HG_STATUS="${HG_STATUS}*"
	fi

	if [[ "${HG_STATUS_SUMMARY}" =~ .*A.* ]]; then
		HG_STATUS="${HG_STATUS}+"
	fi

	if [[ "${HG_STATUS_SUMMARY}" =~ .*R.* ]]; then
		HG_STATUS="${HG_STATUS}✕"
	fi

	if [[ "${HG_STATUS_SUMMARY}" =~ .*!.* ]]; then
		HG_STATUS="${HG_STATUS}!"
	fi

	if [[ "${HG_STATUS_SUMMARY}" =~ .*[?].* ]]; then
		HG_STATUS="${HG_STATUS}?"
	fi

	printf '[%s]' "${HG_STATUS}"
fi
