trap {
	Write-Warning ($_.ScriptStackTrace | Out-String)
}

# Save all output, just in case! Thanks to @vexx32
$PSDefaultParameterValues['Out-Default:OutVariable'] = '__'

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

Install-Module Microsoft.PowerShell.PSResourceGet -Repository PSGallery -AllowClobber

# Install scoop for packages
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# Rehash PATH
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

@(
	"AgileBits.1Password"
	"calibre.calibre"
	"Discord.Discord"
	"EpicGames.EpicGamesLauncher"
	"GIMP.GIMP"
	"Microsoft.PowerShell"
	"Microsoft.PowerToys"
	"Mozilla.Firefox"
	"Mozilla.Thunderbird"
	"Roblox.Roblox"
	"wez.wezterm"
) | ForEach-Object {
	winget install $_ --source winget
}

@(
	"9PMMSR1CGPWG" # HEIF extensions
) | ForEach-Object {
	winget install $_ --source msstore
}

scoop bucket add extras
@(
	"1password-cli"
	"age"
	"chezmoi"
	"difftastic"
	"gcc"
	"git"
	"go"
	"gsudo"
	"lazygit"
	"neovim"
	"nodejs"
	"python"
	"ripgrep"
	"rust"
	"starship"
	"vcredist2022"
) | ForEach-Object {
	scoop install $_
}

gsudo {
	# Enable developer mode
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"

	# Fix git to allow running
	Get-ChildItem C:\Users\jgogu\scoop\apps\git\ -Recurse -Filter git* -File -Exclude *.html,*.vim,*.*rc,*.ico,*.*sh,*.sh,*.pm | ForEach-Object {
		Write-Host $_.FullName
		Set-ProcessMitigation -Name $_.FullName -Disable ForceRelocateImages
	}
	Get-ChildItem C:\Users\jgogu\scoop\apps\git\ -Recurse -Filter *.exe -File -Exclude *.html,*.vim,*.*rc,*.ico,*.*sh,*.sh,*.pm | ForEach-Object {
		Write-Host $_.FullName
		Set-ProcessMitigation -Name $_.FullName -Disable ForceRelocateImages
	}
	Get-ChildItem C:\Users\jgogu\scoop\apps\git\ -Recurse -Filter *.dll -File -Exclude *.html,*.vim,*.*rc,*.ico,*.*sh,*.sh,*.pm | ForEach-Object {
		Write-Host $_.FullName
		Set-ProcessMitigation -Name $_.FullName -Disable ForceRelocateImages
	}
}

Read-Host -Prompt "Open 1Password and configure it to allow CLI access and SSH. Press
Return when ready"

New-Item -ItemType Directory -Path $HOME\.config
New-Item -ItemType Directory -Path $HOME\.ssh

op item get x44krs7dwxr7qhgzjed2fvnh3m --fields 'label=public key' >$HOME\.ssh\codeberg.pub
op document get oylhnlt5t6eoypifnfpjo7uzcm --out-file $HOME\.config\age-chezmoi.txt

if (!(Test-Path $HOME\.local\share\chezmoi)) {
	git clone git@codeberg.org:jgoguen/dotfiles.git $HOME\.local\share\chezmoi
	git --git-dir=$HOME\.local\share\chezmoi config user.signingkey 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILjeyx439ef47Ra12ipQ58UKcadM3Q7RnJyeSsYhhrb4'
}

chezmoi init --apply
