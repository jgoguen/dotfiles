#!/bin/sh
# vim: set noexpandtab tabstop=2 shiftwidth=2 autoindent:
# vim: set foldmarker=[[[,]]] foldmethod=marker foldlevel=0:

set -eu

MYDIR="$(dirname -- "${0}")"

. "${MYDIR}/helpers.sh"

# Define cleanup on script exit or termination [[[
cleanup() {
	if [ -n "${TEMPDIR}" ] && [ -d "${TEMPDIR}" ]; then
		log "Removing temporary directory: ${TEMPDIR}" "DEBUG"
		/bin/rm -rf "${TEMPDIR}"
	fi

	trap - EXIT
}
trap cleanup EXIT INT TERM HUP
# ]]]

# Determine machine architecture and OS type [[[
OSTYPE="$(uname | tr 'A-Z' 'a-z')"
if [ "${OSTYPE}" = "openbsd" ]; then
	SUDO_CMD=/usr/bin/doas
else
	SUDO_CMD=/usr/bin/sudo
fi

MACHINE="$(uname -m)"
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
if [ "${OSTYPE}" = "darwin" ]; then
	log "Checking if XCode tools are ready" "DEBUG"
	if ! xcode-select --print-path >/dev/null 2>&1; then
		log "Installing XCode CLI tools. This can take a while, please be patient." "INFO"
		xcode-select --install >/dev/null 2>&1

		# Wait for xcode-select to be done
		until xcode-select --print-path >/dev/null 2>&1; do
			sleep 2
		done

		# Prompt to agree to license
		log "Running xcodebuild to agree to the license, please enter your password if prompted" "INFO"
		${SUDO_CMD} xcodebuild --license
	fi

	log "Checking if Homebrew is installed at ${HOMEBREW_BIN}" "DEBUG"
	if [ ! -x "${HOMEBREW_BIN}" ]; then
		log "Installing Homebrew, please enter your password if prompted" "INFO"
		OLD_POSIXLY_CORRECT="${POSIXLY_CORRECT}"
		unset POSIXLY_CORRECT
		/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
		POSIXLY_CORRECT="${OLD_POSIXLY_CORRECT}"
		unset OLD_POSIXLY_CORRECT
	fi

	log "Installing Homebrew packages" "INFO"
	${HOMEBREW_BIN} bundle --no-lock --file "${MYDIR}/Brewfile"
elif [ -f /etc/fedora-release ] || [ -f /etc/redhat-release ]; then
	log "Installing needed packages, please enter your password if prompted" "INFO"
	${SUDO_CMD} dnf install --refresh -y curl git-core git-crypt gnupg2 \
		jq libxml2 lsb unzip
elif [ -f /etc/debian_version ]; then
	log "Installing needed packages, please enter your password if prompted" "INFO"
	${SUDO_CMD} apt install -y curl git git-crypt gnupg2 jq \
		libxml2-utils lsb-release unzip
elif [ "${OSTYPE}" = "openbsd" ]; then
	log "Installing needed packages, please enter your password if prompted" "INFO"
	${SUDO_CMD} pkg_add -ru curl git git-crypt gnupg--%gnupg2 jq \
		libxml unzip--
fi
# ]]]

TEMPDIR="$(mktemp -d)"
log "Created temporary directory: ${TEMPDIR}" "DEBUG"

# Install the OpenBSD ports tree if needed [[[
if [ "${OSTYPE}" = "openbsd" ] && [ ! -d /usr/ports ]; then
	log "Installing OpenBSD ports tree" "INFO"
	curl "https://cdn.openbsd.org/pub/OpenBSD/$(uname -r)/ports.tar.gz" | ${SUDO_CMD} tar zxphf - -C /usr
fi
# ]]]

if [ -f /etc/fedora-release ] || [ -f /etc/redhat-release ] || [ -f /etc/centos-release ]; then
	log "Installing 1Password for RPM systems" "INFO"
	log "Installing 1Password GPG key" "DEBUG"
	${SUDO_CMD} rpm --import https://downloads.1password.com/linux/keys/1password.asc
	log "Installing 1Password repo file" "DEBUG"
	${SUDO_CMD} sh -c 'printf "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" >/etc/yum.repos.d/1password.repo'
	${SUDO_CMD} dnf install -y 1password-cli
	if [ -n "${DISPLAY}" ]; then
		${SUDO_CMD} dnf install -y 1password
	fi
fi

# Fetch the op CLI from upstream and install it if needed [[[
# This is janky as fuck screen-scraping to get the package URL, here's hoping
# AgileBits doesn't decide to make minor changes to the page!
if ! which op >/dev/null 2>&1; then
	log "op does not exist, fetching op for ${OSTYPE}_${MACHINE}" "INFO"
	OP_URL="$(curl -fsSL https://app-updates.agilebits.com/product_history/CLI2 2>/dev/null | xmllint --html --dtdattr --xpath "string(//article[not(@class='beta')][1]/div[@class='cli-archs']/p[@class='system ${OSTYPE}']/a[text()='${MACHINE}']/@href)" - 2>/dev/null)"
	log "Fetching 1Password CLI from ${OP_URL}" "DEBUG"
	curl -fsSL "${OP_URL}" >"${TEMPDIR}/op.zip"
	unzip "${TEMPDIR}/op.zip" "${TEMPDIR}/op"
	log "Installing ${TEMPDIR}/op to /usr/local/bin/op" "DEBUG"
	${SUDO_CMD} install -m 0755 -u root -g "$(id -g root)" -s -S "${TEMPDIR}/op" /usr/local/bin/op
fi
# ]]]

if ! which chezmoi >/dev/null 2>&1; then
	log "chezmoi does not exist, fetching chezmoi for ${OSTYPE}_${MACHINE}" "INFO"
	# This is janky as fuck screen-scraping to get the package URL, here's hoping
	# the webpage doesn't change!
	sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "${TEMPDIR}"
	log "Installing ${TEMPDIR}/chezmoi to /usr/local/bin/chezmoi" "DEBUG"
	${SUDO_CMD} install -m 0755 -u root -g "$(id -g root)" -s -S "${TEMPDIR}/chezmoi" /usr/local/bin/chezmoi
fi

if [ "${OSTYPE}" = "darwin" ] || [ -n "${DISPLAY}" ]; then
	if [ "${SSH_AUTH_SOCK}" != "${HOME}/.1password/agent.sock" ]; then
		log "Opening 1Password for configuration, set it up and enable both CLI integration and SSH agent" "INFO"
		if which open >/dev/null 2>&1; then
			open /Applications/1Password.app
			log "Creating compatibility symlink: ${HOME}/.1password -> ${HOME}/Library/Group Containers/2BUA8C4S2C.com.1password/t" "DEBUG"
			ln -sf "${HOME}/Library/Group Containers/2BUA8C4S2C.com.1password/t" "${HOME}/.1password"
		else
			1password
		fi
		printf 'Press Return when 1Password is configured'
		read -r empty
		log "Setting SSH_AUTH_SOCK=${HOME}/.1password/agent.sock" "DEBUG"
		export SSH_AUTH_SOCK="${HOME}/.1password/agent.sock"
	fi
else
	log "Signing in to the 1Password CLI, enter your 1Password email, secret key, and password when prompted" "INFO"
	eval "$(op signin --address my.1password.com)"
fi

if [ ! -d "${HOME}/.local/share" ]; then
	log "Creating directory ${HOME}/.local/share" "DEBUG"
	install -d -m 0700 "${HOME}/.local/share"
fi

if [ ! -d "${HOME}/.ssh" ]; then
	log "Creating directory ${HOME}/.ssh" "DEBUG"
	install -d -m 0700 "${HOME}/.ssh"
fi

log "Fetching codeberg SSH keys from 1Password" "DEBUG"
#op item get x44krs7dwxr7qhgzjed2fvnh3m --fields 'label=private key' --reveal | sed '/"/d' | tr -d '\r' >"${HOME}/.ssh/codeberg"
op item get x44krs7dwxr7qhgzjed2fvnh3m --fields 'label=public key' >"${HOME}/.ssh/codeberg.pub"

log "Fetching dotfiles GPG key from 1Password" "DEBUG"
/usr/local/bin/op document get qukaq3aej2hftq6t2ojuwvpm6m | gpg --import
log "Setting ultimate ownertrust for dotfiles GPG key" "DEBUG"
printf '75E259BA34917C792560A53AE9F9F8EA7E062F78:6:\n' | gpg --import-ownertrust

if [ ! -d "${HOME}/.local/share/chezmoi" ]; then
	log "Dotfiles not present, cloning" "INFO"

	git clone git@codeberg.org:jgoguen/dotfiles.git "${HOME}/.local/share/chezmoi"
	#/bin/rm -f "${HOME}/.ssh/codeberg"

	log "Unlocking dotfiles repo in ${HOME}/.local/share/chezmoi" "DEBUG"
	cd "${HOME}/.local/share/chezmoi"
	git-crypt unlock
fi

log "Initializing chezmoi and applying dotfiles" "INFO"
chezmoi init --apply
