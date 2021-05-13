### 
### Copyright (C) Al West, 2014, TSEW, UK.
###
### Change the line of code below to match the folder where your 
### portable apps are - if you omit the filter then everything found 
### will be added.  Not good!
### 
### To delete links remove the following folder 
###  (copy and paste into explorer window):
###    %appdata%\microsoft\windows\Start Menu\Programs\Portable\
###
### Running this again will only recreate the shortcuts
### It will not delete redundant ones. 
### Also not all files have portable in their name so it doesn't 
### cover everything.
### 

$folder = "C:\PortableApps.com\PortableApps\*Portable.exe" 

###
############################################################## 

function makeSC ( [string]$portableApp ) 
{
 $appName = [io.path]::GetFileNameWithoutExtension($portableApp)
 $location = $env:APPDATA + "\Microsoft\Windows\Start Menu\Programs\"
 $WshShell = New-Object -ComObject WScript.Shell
 # Write-Host "Creating:" $appName " <<>> "  $portableApp
 # Write-Host "      in:" $location 
 $Shortcut = $WshShell.CreateShortcut( $location + $appName + ".lnk")
 $Shortcut.TargetPath = $portableApp
 $Shortcut.Save()
} 

$files = Get-ChildItem -Path ($folder) -Recurse 

foreach ($file in $files)
{ 
 makeSC ($file)
} 