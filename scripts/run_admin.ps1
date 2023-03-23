fsutil 8dot3name set 1
$DOTFILES = "$env:USERPROFILE\.dotfiles"
$DOTCONFIG = "$DOTFILES\.config"
$DOTNIXCONFIG = "$DOTCONFIG\from_nixos\apps"
$PSUSERHOME = $profile -replace "^(.*)\\.*$", "`$1" -replace "^(.*)\\.*$", "`$1"

# windows defenderのスキャン対象から外す
Add-MpPreference -ExclusionPath $env:USERPROFILE\.cache
Add-MpPreference -ExclusionPath $env:USERPROFILE\.config
Add-MpPreference -ExclusionPath $env:USERPROFILE\.dotfiles
Add-MpPreference -ExclusionPath $env:USERPROFILE\bin
Add-MpPreference -ExclusionPath $env:USERPROFILE\scoop
Add-MpPreference -ExclusionPath $env:USERPROFILE\src
Add-MpPreference -ExclusionPath $env:USERPROFILE\pkg
Add-MpPreference -ExclusionPath "$env:USERPROFILE\Hyper-V"
Add-MpPreference -ExclusionPath "$env:USERPROFILE\VirtualBox VMs"
Add-MpPreference -ExclusionPath $env:ProgramData\scoop
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Value 1
Set-ItemProperty "HKCU:\Control Panel\Desktop" -Name "PaintDesktopVersion" -Value 1

# local manifestからwingetできるようにする
winget settings --enable LocalManifestFiles

switch ((Get-WmiObject -Class Win32_ComputerSystem).Model) {
  "Virtual Machine" {
    $isVM = $true
  }
  "VMware Virtual Platform" {
    $isVM = $true
  }
  "VirtualBox" {
    $isVM = $true
  }
  default {
    $isVM = $false
  }
}

$enableFeatures = @(
  "TelnetClient"
)
$disableFeatures = @(
  "WorkFolders-Client"
)
if (! $isVM) {
  $virtualizationFeatures = @(
    "Containers"
    "Microsoft-Hyper-V"
    "Microsoft-Windows-Subsystem-Linux"
    "HypervisorPlatform"
    "VirtualMachinePlatform"
  )
  $enableFeatures += $virtualizationFeatures
}

foreach ($enableFeature in $enableFeatures) {
  if ((Get-WindowsOptionalFeature -Online -FeatureName $enableFeature).State -eq "Disabled") {
    Write-Output "Try to enable $enableFeature"
    Enable-WindowsOptionalFeature -Online -All -NoRestart -FeatureName $enableFeature
  }
  else {
    Write-Output "$enableFeature has been already enabled"
  }
}

foreach ($disableFeature in $disableFeatures) {
  if ((Get-WindowsOptionalFeature -Online -FeatureName $disableFeature).State -eq "Enabled") {
    Write-Output "Try to disable $disableFeature"
    Disable-WindowsOptionalFeature -Online -NoRestart -FeatureName $disableFeature
  }
  else {
    Write-Output "$disableFeature has been already disabled"
  }
}

# profile
# New-Item -Force -ItemType SymbolicLink -Path $env:USERPROFILE\.profile.ps1 -Value $DOTCONFIG\powershell\profile.ps1
# Windows Powershell
New-Item -Force -ItemType SymbolicLink -Path $PSUSERHOME\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 -Value $DOTCONFIG\powershell\profile.ps1
# Powershell Core
New-Item -Force -ItemType SymbolicLink -Path $PSUSERHOME\PowerShell\Microsoft.PowerShell_profile.ps1 -Value $DOTCONFIG\powershell\profile.ps1

# starship
New-Item -Force -ItemType SymbolicLink -Path $env:USERPROFILE\.config\starship\starship.toml -Value $DOTNIXCONFIG\common\shell\starship\starship.toml

# komorebi
New-Item -Force -ItemType SymbolicLink -Path $env:USERPROFILE\.config\komorebi -Value $DOTCONFIG\komorebi

## VSCode
New-Item -Force -ItemType SymbolicLink -Path $PSUSERHOME\WindowsPowerShell\Microsoft.VSCode_profile.ps1 -Value $DOTCONFIG\profile.ps1

# editorconfig
New-Item -Force -ItemType SymbolicLink -Path $env:USERPROFILE\.editorconfig -Value $DOTNIXCONFIG\common\editorconfig\.editorconfig

# nvim
New-Item -Force -ItemType SymbolicLink -Path $env:LOCALAPPDATA\nvim -Value $DOTFILES\.config\nvim

wsl --update
wsl --shutdown

# Powershell modules
Install-Module -Force -Scope CurrentUser syntax-highlighting
Install-Module -Force -Scope CurrentUser PSWindowsUpdate
Install-Module -Force -Scope CurrentUser WslInterop
Install-Module -Force -Scope CurrentUser PSFzf

# git
New-Item -Force -ItemType SymbolicLink -Path $env:USERPROFILE\.gitconfig -Value $DOTCONFIG\git\config
New-Item -Force -ItemType SymbolicLink -Path $env:USERPROFILE\.gitignore -Value $DOTNIXCONFIG\common\git\gitignore
New-Item -Force -ItemType SymbolicLink -Path $env:USERPROFILE\.gitmessage -Value $DOTNIXCONFIG\common\git\gitmessage
# wezterm
New-Item -Force -ItemType SymbolicLink -Path $env:USERPROFILE\.config\wezterm -Value $DOTNIXCONFIG\desktop\terminal\wezterm
# New-Item -Force -ItemType SymbolicLink -Path $env:USERPROFILE\.bashrc -Value $DOTFILES\.bashrc.windows

# ruby
# New-Item -Force -ItemType SymbolicLink -Path $env:USERPROFILE\.gemrc -Value $DOTFILES\.gemrc

# vim
# New-Item -Force -ItemType SymbolicLink -Path $env:USERPROFILE\.vimrc -Value $DOTFILES\.vimrc
# New-Item -Force -ItemType SymbolicLink -Path $env:USERPROFILE\.ideavimrc -Value $DOTFILES\.ideavimrc

# code
# New-Item -Force -ItemType SymbolicLink -Path $env:APPDATA\Code\User\settings.json -Value $DOTFILES\.config\Code\User\settings.json
# New-Item -Force -ItemType SymbolicLink -Path $env:APPDATA\Code\User\keybindings.json -Value $DOTFILES\.config\Code\User\keybindings.json
# New-Item -Force -ItemType SymbolicLink -Path $env:APPDATA\Code` -` Insiders\User\settings.json -Value $DOTFILES\.config\Code\User\settings.json
# New-Item -Force -ItemType SymbolicLink -Path $env:APPDATA\Code` -` Insiders\User\keybindings.json -Value $DOTFILES\.config\Code\User\keybindings.json

# msys2
# $MSYSHOME = "$env:USERPROFILE\scoop\persist\msys2\home\$env:USERNAME"
# New-Item -Force -ItemType SymbolicLink -Path $MSYSHOME\.editorconfig -Value $DOTFILES\.editorconfig
# New-Item -Force -ItemType SymbolicLink -Path $MSYSHOME\.gitconfig -Value $DOTFILES\.gitconfig
# New-Item -Force -ItemType SymbolicLink -Path $MSYSHOME\.gitignore -Value $DOTFILES\.gitignore
# New-Item -Force -ItemType SymbolicLink -Path $MSYSHOME\.gitmessage -Value $DOTFILES\.gitmessage
# New-Item -Force -ItemType SymbolicLink -Path $MSYSHOME\.gemrc -Value $DOTFILES\.gemrc
# New-Item -Force -ItemType SymbolicLink -Path $MSYSHOME\.tmux.conf -Value $DOTFILES\.tmux.conf
# New-Item -Force -ItemType SymbolicLink -Path $MSYSHOME\.vimrc -Value $DOTFILES\.vimrc

# Windows Terminal
# New-Item -Force -ItemType SymbolicLink -Path $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Value $DOTFILES\.config\WindowsTerminal\LocalState\settings.json
# New-Item -Force -ItemType SymbolicLink -Path $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json -Value $DOTFILES\.config\WindowsTerminal\LocalState\settings.json

# memo
# New-Item -Force -ItemType SymbolicLink -Path $env:APPDATA\memo\config.toml -Value $DOTFILES\.config\memo\config.toml

# ssh
# New-Item -Force -ItemType SymbolicLink -Path $env:USERPROFILE\.ssh\config -Value $DOTFILES\.ssh\config.windows

