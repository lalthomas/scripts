# Script create useful shortcuts of scripts in send to folder
# Lal Thomas
# 2017-01-02
# thanks http://stackoverflow.com/a/30029955/2182047

param ( 
	[string]$filename,
    [string]$linkname
	)
	
# write-output $filename
# write-output $linkname

# get the sendto folder path
$sendto = [System.Environment]::GetFolderPath('Sendto')
$wshshell=(New-Object -COM WScript.Shell)
$lnk = $wshshell.CreateShortcut($sendto+'\'+$linkname)
$lnk.TargetPath = $filename
$lnk.Save()
