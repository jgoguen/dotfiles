#!/bin/sh
# vim: set noexpandtab tabstop=2 shiftwidth=2 autoindent:
# vim: set foldmarker=[[[,]]] foldmethod=marker foldlevel=0:

set -eux

# Define cleanup on script exit or termination [[[
cleanup() {
	if [ -d "${TEMPDIR}" ]; then
		/bin/rm -rf "${TEMPDIR}"
	fi

	trap - EXIT
}
trap cleanup EXIT INT TERM HUP
# ]]]

# Determine machine architecture and OS type [[[
UNAME_BIN="$(command -pv uname)"
if [ -z "${UNAME_BIN}" ]; then
	printf 'Required tool uname not found\n' >&2
	exit 1
fi

OSTYPE="$("${UNAME_BIN}" | /usr/bin/tr '[:upper:]' '[:lower:]')"
if [ "${OSTYPE}" = "openbsd" ]; then
	SUDO_CMD=/usr/bin/doas
else
	SUDO_CMD=/usr/bin/sudo
fi

MACHINE="$("${UNAME_BIN}" -m)"
case "${MACHINE}" in
	x86_64)
		MACHINE="amd64"
		HOMEBREW_BIN="/usr/local/bin/brew"
		;;
	arm*)
		if [ "${OSTYPE}" = "darwin" ]; then
			MACHINE="arm64"
		else
			MACHINE="arm"
		fi
		HOMEBREW_BIN="/opt/homebrew/bin/brew"
		;;
	aarch64)
		MACHINE="arm64"
		HOMEBREW_BIN="/opt/homebrew/bin/brew"
		;;
esac
# ]]]

# Install packages required for setup [[[
# Running this script assumes the Ansible setup script (see
# https://codeberg.org/jgoguen/ansible_playbooks/blob/main/setup.sh) has been
# run and only installs packages not needed for Ansible setup.
if [ "${OSTYPE}" = "darwin" ]; then
	# However, because XCode can be fussy sometimes, this is duplicated Just In
	# Case.
	if ! xcode-select --print-path >/dev/null 2>&1; then
		printf 'Installing XCode CLI tools\n'
		xcode-select --install >/dev/null 2>&1

		# Wait for xcode-select to be done
		until xcode-select --print-path >/dev/null 2>&1; do
			printf '.'
			sleep 5
		done
		print '\n'

		# Prompt to agree to license
		${SUDO_CMD} xcodebuild --license
	fi

	${HOMEBREW_BIN} install jq
elif [ -f /etc/fedora-release ] || [ -f /etc/redhat-release ]; then
	${SUDO_CMD} /usr/bin/dnf install --refresh -y jq
elif [ -f /etc/debian_version ]; then
	${SUDO_CMD} /usr/bin/apt install -y jq
elif [ "${OSTYPE}" = "openbsd" ]; then
	${SUDO_CMD} /usr/sbin/pkg_add -ru jq
fi
# ]]]

# Locate other tools on the system [[[
CURL_BIN="$(command -v curl)"
if [ -z "${CURL_BIN}" ]; then
	printf 'Required tool curl not found\n' >&2
	exit 1
fi

MKTEMP_BIN="$(command -v mktemp)"
if [ -z "${MKTEMP_BIN}" ]; then
	printf 'Required tool mktemp not found\n' >&2
	exit 1
fi

OP_BIN="$(command -v op)"
if [ -z "${OP_BIN}" ]; then
	printf 'Required tool op not found\n' >&2
	exit 1
fi

TAR_BIN="$(command -v tar)"
if [ -z "${TAR_BIN}" ]; then
	printf 'Required tool tar not found\n' >&2
	exit 1
fi

XMLLINT_BIN="$(command -v xmllint)"
if [ -z "${XMLLINT_BIN}" ]; then
	printf 'Required tool xmllint not found\n' >&2
	exit 1
fi
# ]]]

TEMPDIR="$("${MKTEMP_BIN}" -d XXXXXXXXXXXXXXXX)"

set +e
CHEZMOI_BIN="$(command -v chezmoi)"
set -e
if [ -z "${CHEZMOI_BIN}" ]; then
	# This is janky as fuck screen-scraping to get the package URL, here's hoping
	# the webpage doesn't change!
	CHEZMOI_PKG_URL="$(${CURL_BIN} -fsSL https://www.chezmoi.io/install/ 2>/dev/null | ${XMLLINT_BIN} --html --dtdattr --xpath "string(//h2[@id='download-a-pre-built-binary']/following-sibling::div[1]//a[contains(@href, '${OSTYPE}_${MACHINE}.tar.gz')]/@href)" - 2>/dev/null)"
	${CURL_BIN} -fsSL "${CHEZMOI_PKG_URL}" >"${TEMPDIR}/chezmoi.tar.gz"

	${SUDO_CMD} ${TAR_BIN} zxf "${TEMPDIR}/chezmoi.tar.gz" -C /usr/local/bin chezmoi
	CHEZMOI_BIN=/usr/local/bin/chezmoi
fi

eval "$(/usr/local/bin/op signin)"

if [ ! -d "${HOME}/.local/share" ]; then
	/bin/mkdir -p "${HOME}/.local/share"
fi

if [ ! -d "${HOME}/.local/share/chezmoi" ]; then
	if [ ! -d "${HOME}/.ssh" ]; then
		/bin/mkdir -p "${HOME}/.ssh"
	fi

	${OP_BIN} item get x44krs7dwxr7qhgzjed2fvnh3m --fields 'label=private key' --reveal | sed '/"/d' | tr -d '\r' >"${HOME}/.ssh/codeberg"
	${OP_BIN} item get x44krs7dwxr7qhgzjed2fvnh3m --fields 'label=public key' >"${HOME}/.ssh/codeberg.pub"
	/bin/chmod 0700 "${HOME}/.ssh"
	/bin/chmod 0600 "${HOME}"/.ssh/*

	/usr/local/bin/op document get qukaq3aej2hftq6t2ojuwvpm6m | gpg --import
	printf '75E259BA34917C792560A53AE9F9F8EA7E062F78:6:\n' | gpg --import-ownertrust

	$(command -v git) clone --config core.sshCommand="ssh -i ${HOME}/.ssh/codeberg" git@codeberg.org:jgoguen/dotfiles.git "${HOME}/.local/share/chezmoi"
	/bin/rm -f "${HOME}/.ssh/codeberg"
	cd "${HOME}/.local/share/chezmoi"
	$(command -v git-crypt) unlock
fi

${CHEZMOI_BIN} init --apply
