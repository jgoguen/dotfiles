__ESCAPE="\e"
__BLUE=34
__GREEN=32
__YELLOW=33
__RED=31
__RESET=0

log() {
	LEVEL="${2:-INFO}"

	COLOR="${__RESET}"
	if [ "${LEVEL}" = "DEBUG" ]; then
		COLOR="${__BLUE}"
	elif [ "${LEVEL}" = "INFO" ]; then
		COLOR="${__GREEN}"
	elif [ "${LEVEL}" = "WARN" ]; then
		COLOR="${__YELLOW}"
	elif [ "${LEVEL}" = "ERROR" ]; then
		COLOR="${__RED}"
	fi

	printf '\x1b[%dm%s [%s] %s\x1b[0m\n' "${COLOR}" "$(date +"%Y-%m-%d %H:%M:%S")" "${LEVEL}" "${1}"
}
