# thanks https://stackoverflow.com/a/31602095
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

# create link on start up folder
# thanks https://www.anoopcnair.com/windows-10-add-applications-startup-msconfig/
$StartUp="$Env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"

# lauchy
New-Item -ItemType SymbolicLink -Path "$StartUp" -Name "launchy.lnk" -Value "D:\Portable\launchy\Launchy.exe"

# Pause
# Read-Host -Prompt "Press Enter to continue"
