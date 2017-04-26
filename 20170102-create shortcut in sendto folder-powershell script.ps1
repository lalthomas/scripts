# Script create useful shortcuts of scripts in send to folder
# Lal Thomas
# 2017-01-02
# thanks http://stackoverflow.com/a/30029955/2182047

param ( 
	[Parameter(Mandatory = $true)][string]$filename,
	[Parameter(Mandatory = $true)][string]$linkname,	
	[string]$switch
	)
	
# write-output $filename
# write-output $linkname
# write-output $switch

# get the sendto folder path
$sendto = [System.Environment]::GetFolderPath('Sendto')
$wshshell=(New-Object -COM WScript.Shell)
$lnk = $wshshell.CreateShortcut($sendto+'\'+$linkname)

# add switch if the argument is not empty
if ([string]::IsNullOrWhitespace($switch)) { 
	
	$lnk.TargetPath = $filename
}
else { 
	
	$args='"{0}"' -f $switch;
	
	$lnk.TargetPath = "$filename"		
	$lnk.Arguments = $args
	
}

$lnk.Save()

# Pause
# cmd /c pause | out-null