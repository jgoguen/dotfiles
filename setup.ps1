trap {
	Write-Warning ($_.ScriptStackTrace | Out-String)
}

# Save all output, just in case! Thanks to @vexx32
$PSDefaultParameterValues['Out-Default:OutVariable'] = '__'

$ENV:GIT_SSH = C:\\Windows\\System32\\OpenSSH\\ssh.exe
$ENV:XDG_CONFIG_HOME = if ($ENV:XDG_CONFIG_HOME) {
	$ENV:XDG_CONFIG_HOME
}
else {
	[IO.Path]::Combine($HOME, ".config")
}
$ENV:XDG_DATA_HOME = if ($ENV:XDG_DATA_HOME) {
	$ENV:XDG_DATA_HOME
}
else {
	[IO.Path]::Combine($HOME, ".local", "share")
}

# Install scoop for packages
if (!(Test-Path $HOME\scoop)) {
	Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
	Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

# Rehash PATH
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

if (!(Test-Path C:\Users\jgogu\AppData\Local\1Password\app\8\1Password.exe)) {
	$downloadsPath = (New-Object -ComObject Shell.Application).Namespace('shell:Downloads').Self.Path
	$onepasswordInstaller = Join-Path $downloadsPath "1PasswordSetup-latest.exe"
	Invoke-WebRequest -Uri "https://downloads.1password.com/win/1PasswordSetup-latest.exe" -OutFile $onepasswordInstaller
	Start-Process $onepasswordInstaller -Verb RunAs -Wait
}

scoop install git
scoop bucket add extras
@(
	"1password-cli"
	"age"
	"chezmoi"
	"gsudo"
	"python"
) | ForEach-Object {
	scoop install $_
}

gsudo {
	Install-Module Microsoft.PowerShell.PSResourceGet -Repository PSGallery -AllowClobber
	Install-Module Pscx -Repository PSGallery -AllowClobber

	# Enable developer mode
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"

	# Fix git to allow running
	Get-ChildItem $HOME\scoop\apps\git\ -Recurse -Filter git* -File -Exclude *.html,*.vim,*.*rc,*.ico,*.*sh,*.sh,*.pm | ForEach-Object {
		Write-Host $_.FullName
		Set-ProcessMitigation -Name $_.FullName -Disable ForceRelocateImages
	}
	Get-ChildItem $HOME\scoop\apps\git\ -Recurse -Filter *.exe -File -Exclude *.html,*.vim,*.*rc,*.ico,*.*sh,*.sh,*.pm | ForEach-Object {
		Write-Host $_.FullName
		Set-ProcessMitigation -Name $_.FullName -Disable ForceRelocateImages
	}
	Get-ChildItem $HOME\scoop\apps\git\ -Recurse -Filter *.dll -File -Exclude *.html,*.vim,*.*rc,*.ico,*.*sh,*.sh,*.pm | ForEach-Object {
		Write-Host $_.FullName
		Set-ProcessMitigation -Name $_.FullName -Disable ForceRelocateImages
	}
	Get-ChildItem $HOME\scoop\shims -Recurse -Filter git*.exe -File | ForEach-Object {
		Write-Host $_.FullName
		Set-ProcessMitigation -Name $_.FullName -Disable ForceRelocateImages
	}
}

Read-Host -Prompt "Open 1Password and configure it to allow CLI access and SSH. Press
Return when ready"

if (!(Test-Path $HOME\.config)) {
	New-Item -ItemType Directory -Path $HOME\.config
}
if (!(Test-Path $HOME\.ssh)) {
	New-Item -ItemType Directory -Path $HOME\.ssh -Force
}

if (!(Test-Path $HOME\.ssh\git.pub)) {
	op item get yhriphcxvz4pewyxhtjoxgjv6m --fields 'label=public key' >$HOME\.ssh\git.tmp
	ConvertTo-UnixLineEnding -Path $HOME\.ssh\git.tmp -Destination $HOME\.ssh\git.pub
	Remove-Item $HOME\.ssh\git.tmp
}
if (!(Test-Path $HOME\.config\age-chezmoi.txt)) {
	op document get oylhnlt5t6eoypifnfpjo7uzcm --out-file $HOME\.config\age-chezmoi.txt
}

if (!(Test-Path $HOME\.local\share\chezmoi)) {
	if (!(Test-Path $HOME\.ssh\config)) {
		New-Item $HOME\.ssh\config -ItemType File -Value "Host github.com`n`tIdentitiesOnly yes`n`tIdentityFile ~/.ssh/git.pub`n`tUser git`n"
	}
	git clone git@github.com:jgoguen/dotfiles.git $HOME\.local\share\chezmoi
	git --git-dir=$HOME\.local\share\chezmoi config user.signingkey 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK5Z49qDHmr2+Io9lOzDCnb5QD4EERq6bJAOqYxD0THx'
}

chezmoi init --apply
