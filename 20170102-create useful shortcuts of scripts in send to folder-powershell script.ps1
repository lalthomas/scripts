# Script create useful shortcuts of scripts in send to folder
# Lal Thomas
# 2017-01-02
# thanks http://stackoverflow.com/a/30029955/2182047

# cd %APPDATA%\Microsoft\Windows\SendTo

# get the sendto folder path
$sendto = [System.Environment]::GetFolderPath('Desktop')
$wshshell=(New-Object -COM WScript.Shell)
$lnk = $wshshell.CreateShortcut($sendto+'\shortcuts.lnk')
$lnk.TargetPath = "D:\temp"
$lnk.Save()
