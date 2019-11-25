# Script to create shortcut on desktop
# Lal Thomas
# 2018-08-09

param ( 
	[Parameter(Mandatory = $true)][string]$filename,
	[Parameter(Mandatory = $true)][string]$linkname,	
	[string]$switch
	)
	
# write-output $filename
# write-output $linkname
# write-output $switch

# get the sendto folder path
$folderlocation = [System.Environment]::GetFolderPath('Desktop')
$wshshell=(New-Object -COM WScript.Shell)
$lnk = $wshshell.CreateShortcut($folderlocation+'\'+$linkname)

# add switch if the argument is not empty
if ([string]::IsNullOrWhitespace($switch)) { 
	
	$lnk.TargetPath = $filename
}
else { 
	
	$args='{0}' -f $switch;	
	$lnk.TargetPath = "$filename"		
	$lnk.Arguments = $args
	
}

$lnk.Save()

# Pause
# cmd /c pause | out-null