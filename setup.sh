#!/bin/sh

set -eu

MYDIR="$(dirname -- "${0}")"

. "${MYDIR}/helpers.sh"

# Define cleanup on script exit or termination
cleanup() {
	if [ -n "${TEMPDIR}" ] && [ -d "${TEMPDIR}" ]; then
		log "Removing temporary directory: ${TEMPDIR}" "DEBUG"
		/bin/rm -rf "${TEMPDIR}"
	fi

	trap - EXIT
}
trap cleanup EXIT INT TERM HUP

# Determine machine architecture and OS type
OSTYPE="$(uname | tr '[:upper:]' '[:lower:]')"
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

TEMPDIR="$(mktemp -d)"
log "Created temporary directory: ${TEMPDIR}" "DEBUG"

log "Running setup for OS ${OSTYPE} ${MACHINE}" "INFO"

# Install packages required for setup
if [ "${OSTYPE}" = "darwin" ]; then
	log "Checking if XCode tools are ready" "DEBUG"
	if ! xcode-select --print-path >/dev/null 2>&1; then
		log "Installing XCode CLI tools. This can take a while, please be patient." "INFO"
		xcode-select --install >/dev/null 2>&1

		# Wait for xcode-select to be done
		until xcode-select --print-path >/dev/null 2>&1; do
			sleep 2
		done
	fi

	log "Checking if Homebrew is installed at ${HOMEBREW_BIN}" "DEBUG"
	if [ ! -x "${HOMEBREW_BIN}" ]; then
		log "Installing Homebrew, please enter your password if prompted" "INFO"
		OLD_POSIXLY_CORRECT="${POSIXLY_CORRECT}"
		unset POSIXLY_CORRECT
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
		POSIXLY_CORRECT="${OLD_POSIXLY_CORRECT}"
		unset OLD_POSIXLY_CORRECT
	fi

	log "Installing Homebrew packages for setup" "INFO"
	${HOMEBREW_BIN} install git git-crypt gnupg
	PATH="${PATH}:$(dirname -- "${HOMEBREW_BIN}")"
	export PATH

	log "Grant Full Disk Access to WezTerm.app. Press Return when ready." "WARN"
	open /System/Library/PreferencePanes/Security.prefPane
	read -r
elif [ -f /etc/fedora-release ] || [ -f /etc/redhat-release ]; then
	log "Installing needed packages, please enter your password if prompted" "INFO"
	${SUDO_CMD} dnf install --refresh -y bat curl dnf-plugins-core git-core git-crypt gnupg2 jq libxml2 lsb unzip

	log "Installing bottom from COPR" "INFO"
	sudo dnf copr enable -y atim/bottom
	sudo dnf install -y bottom
elif [ -f /etc/arch-release ]; then
	log "Installing needed packages, please enter your password if prompted" "INFO"
	${SUDO_CMD} pacman -S --noconfirm --needed $(awk '/^pacman = \[$/{flag=1; next} /^\]$/{flag=0; next} flag{split($0, a, "\""); if (a[2] != "") {print a[2]}}' "${MYDIR}/.chezmoidata/packages.toml" | tr '\n' ' ')

	SERVICES="\
		sddm \
		wpa_supplicant \
		NetworkManager \
		avahi-daemon \
		avahi-dnsconfd \
		cups \
		plocate-updatedb.timer \
		chronyd"

	for svc in ${SERVICES}; do
		log "Enabling ${svc} to start on boot" "DEBUG"
		${SUDO_CMD} systemctl enable "${svc}"
	done

	if ! command -v yay >/dev/null 2>&1; then
		curl -o "${TMPDIR}/yay.tar.gz" https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
		tar zxf "${TMPDIR}/yay.tar.gz" -C "${TMPDIR}"
		cd "${TMPDIR}/yay"
		makepkg -sCci
		cd -
		rm -rf "${TMPDIR}/yay"
	fi

	yay --answerclean NotInstalled --answerdiff None --removemake --cleanafter --norebuild -S --needed $(awk '/^aur = \[$/{flag=1; next} /^\]$/{flag=0; next} flag{split($0, a, "\""); if (a[2] != "") {print a[2]}}' "${MYDIR}/.chezmoidata/packages.toml" | tr '\n' ' ')
elif [ "${OSTYPE}" = "openbsd" ]; then
	log "Installing needed packages, please enter your password if prompted" "INFO"
	${SUDO_CMD} pkg_add -ru curl git git-crypt gnupg--%gnupg2 jq libxml unzip--
fi

# Install the OpenBSD ports tree if needed
if [ "${OSTYPE}" = "openbsd" ] && [ ! -d /usr/ports ]; then
	log "Installing OpenBSD ports tree" "INFO"
	curl "https://cdn.openbsd.org/pub/OpenBSD/$(uname -r)/ports.tar.gz" | ${SUDO_CMD} tar zxphf - -C /usr
fi

if [ -f /etc/fedora-release ] || [ -f /etc/redhat-release ] || [ -f /etc/centos-release ]; then
	log "Installing 1Password for RPM systems" "INFO"
	log "Installing 1Password GPG key" "DEBUG"
	${SUDO_CMD} rpm --import https://downloads.1password.com/linux/keys/1password.asc
	log "Installing 1Password repo file" "DEBUG"
	# shellcheck disable=SC2016
	${SUDO_CMD} sh -c 'printf "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" >/etc/yum.repos.d/1password.repo'
	${SUDO_CMD} dnf install -y 1password-cli
	if [ -n "${DISPLAY:-}" ]; then
		${SUDO_CMD} dnf install -y 1password
	fi
fi

# Fetch the op CLI from upstream and install it if needed
# This is janky as fuck screen-scraping to get the package URL, here's hoping
# AgileBits doesn't decide to make minor changes to the page!
if ! which op >/dev/null 2>&1; then
	log "op does not exist, fetching op for ${OSTYPE}_${MACHINE}" "INFO"
	OP_URL="$(curl -fsSL https://app-updates.agilebits.com/product_history/CLI2 2>/dev/null | xmllint --html --dtdattr --xpath "string(//article[not(@class='beta')][1]/div[@class='cli-archs']/p[@class='system ${OSTYPE}']/a[text()='${MACHINE}']/@href)" - 2>/dev/null)"
	log "Fetching 1Password CLI from ${OP_URL}" "DEBUG"
	curl -fsSL "${OP_URL}" >"${TEMPDIR}/op.zip"
	unzip "${TEMPDIR}/op.zip" "${TEMPDIR}/op"
	log "Installing ${TEMPDIR}/op to /usr/local/bin/op" "DEBUG"
	${SUDO_CMD} install -m 0755 -o root -g "$(id -g root)" -s -S "${TEMPDIR}/op" /usr/local/bin/op
fi

if ! which chezmoi >/dev/null 2>&1; then
	log "chezmoi does not exist, fetching chezmoi for ${OSTYPE}_${MACHINE}" "INFO"
	sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "${TEMPDIR}"
	log "Installing ${TEMPDIR}/chezmoi to /usr/local/bin/chezmoi" "DEBUG"
	${SUDO_CMD} install -m 0755 -o root -g "$(id -g root)" -s -S "" "${TEMPDIR}/chezmoi" /usr/local/bin/chezmoi
fi

if [ "${OSTYPE}" = "darwin" ] || [ -n "${DISPLAY:-}" ] || [ -n "${WAYLAND_DISPLAY:-}" ]; then
	log "Opening 1Password for configuration, set it up and enable both CLI integration and SSH agent" "INFO"
	if [ "${OSTYPE}" = "darwin" ]; then
		open /Applications/1Password.app
		export SSH_AUTH_SOCK="${HOME}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
	else
		1password >/dev/null 2>&1 &
		disown
		export SSH_AUTH_SOCK="${HOME}/.1password/agent.sock"
	fi
	printf 'Press Return when 1Password is configured'
	read -r
	log "Setting SSH_AUTH_SOCK=${SSH_AUTH_SOCK}" "DEBUG"
	export SSH_AUTH_SOCK="${HOME}/.1password/agent.sock"
else
	log "Signing in to the 1Password CLI, enter your 1Password email, secret key, and password when prompted" "INFO"
	eval "$(op signin)"
fi

if [ ! -d "${HOME}/.local/share" ]; then
	log "Creating directory ${HOME}/.local/share" "DEBUG"
	install -d -m 0700 "${HOME}/.local/share"
fi

if [ ! -d "${HOME}/.ssh" ]; then
	log "Creating directory ${HOME}/.ssh" "DEBUG"
	install -d -m 0700 "${HOME}/.ssh"
fi

log "Fetching GitHub SSH keys from 1Password" "DEBUG"
op item get iasvzaqvii5rzkm7byrflhrr3m --fields 'label=public key' >"${HOME}/.ssh/git.pub"

log "Fetching dotfiles Age key from 1Password" "DEBUG"
op document get hembrkxzg4mdkgefbf6nh7kyge --out-file "${HOME}/.config/age-chezmoi.txt"
chmod 0600 "${HOME}/.config/age-chezmoi.txt"

if [ ! -d "${HOME}/.local/share/chezmoi" ]; then
	log "Dotfiles not present, cloning" "INFO"

	git clone git@vcs.jgoguen.ca:jgoguen/dotfiles.git "${HOME}/.local/share/chezmoi"

	log "Setting Github key for git signing" "DEBUG"
	git -C "${HOME}/.local/share/chezmoi" config user.signingkey 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK5Z49qDHmr2+Io9lOzDCnb5QD4EERq6bJAOqYxD0THx'
fi

log "Initializing chezmoi and applying dotfiles" "INFO"
useBioUnlock="false"
if [ -n "${DISPLAY:-}" ] || [ -n "${WAYLAND_DISPLAY:-}" ]; then
	useBioUnlock="true"
fi
OP_BIOMETRIC_UNLOCK_ENABLED=${useBioUnlock} chezmoi apply --init
