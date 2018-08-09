# thanks https://stackoverflow.com/a/31602095
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

# thanks : https://code.adonline.id.au/folder-file-browser-dialogues-powershell/
Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
    Multiselect = $false # Multiple files can be chosen
	Filter = 'Executables (*.exe, *.bat,*.sh)|*.exe;*.bat;*.sh' # Specified file types
} 
[void]$FileBrowser.ShowDialog()

If($FileBrowser.FileNames -like "*\*") {

	# Do something 
	$FileBrowser.FileName #Lists selected files (optional)
	$filepath = $FileBrowser.FileName;
	# thanks https://stackoverflow.com/a/35813307
	$filename = Split-Path $filepath -leaf
		
}
else {
    Write-Host "Cancelled by user"
}

# create link on start up folder
$StartUp = [System.Environment]::GetFolderPath('Startup')
# New-Item -ItemType SymbolicLink -Path "$StartUp" -Name "Calculator.lnk" -Value "c:\windows\system32\calc.exe"
New-Item -ItemType SymbolicLink -Path "$StartUp" -Name $filename -Value $filepath
# Pause
# Read-Host -Prompt "Press Enter to continue"
