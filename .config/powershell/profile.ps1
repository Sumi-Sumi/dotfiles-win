Import-Module syntax-highlighting

# 予測変換の有効化
Set-PSReadLineOption -PredictionSource History
# 重複したコマンドは履歴に残さない
Set-PSReadlineOption -HistoryNoDuplicates
# ベルの無効化
Set-PSReadlineOption -BellStyle None
# zsh like候補選択
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
# キーバインド
# Set-PSReadLineOption -EditMode vi
# vi modeの表示
# function OnViModeChange {
#     if ($args[0] -eq 'Command') {
#         # Set the cursor to a blinking block.
#         Write-Host -NoNewLine "`e[1 q"
#     } else {
#         # Set the cursor to a blinking line.
#         Write-Host -NoNewLine "`e[5 q"
#     }
# }
# Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange
# ctrl+dでpowershellを抜ける
Set-PSReadLineKeyHandler -Chord Ctrl+d -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert('exit')
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
# fzf options
# $env:FZF_DEFAULT_COMMAND = '--files --hidden --glob "!.git"'
$env:FZF_DEFAULT_OPTS = '--reverse --border'

$localrc = "$env:HOMEPATH/.profile.local.ps1"
if (Test-Path $localrc) {
  . $localrc
}
# WSLのコマンドをpowershellから呼び出す
# Import-WslCommand "apt", "awk", "emacs", "find", "grep", "head", "less", "ls", "man", "sed", "seq", "ssh", "sudo", "tail", "touch"
# fzfの統合
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
# starshipの有効化
Invoke-Expression (& '~/scoop/apps/starship/current/starship.exe' init powershell --print-full-init | Out-String)
