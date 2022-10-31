# tab completion
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadlineOption -BellStyle Visual
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# ls with color
# sudo Install-Module -AllowClobber Get-ChildItemColor
Import-Module Get-ChildItemColor

Import-Module C:\Users\qianlv\scoop\modules\scoop-completion
# Invoke-Expression (&scoop-search --hook)

# Alias
Set-Alias -Name notepad -Value notepad3.exe
Set-Alias -Name vim -Value nvim
Set-Alias -Name md5sum -Value "C:\Users\qianlv\scoop\apps\git\current\usr\bin\md5sum"
Set-Alias -Name open -Value start

Invoke-Expression (&starship init powershell)
