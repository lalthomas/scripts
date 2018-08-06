
Set-ExecutionPolicy Unrestricted

# thanks : https://powershell.org/forums/topic/powershell-ruan-as-administrator/

function IsAdministrator
{
    $Identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $Principal = New-Object System.Security.Principal.WindowsPrincipal($Identity)
    $Principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

function IsUacEnabled
{
    (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System).EnableLua -ne 0
}

if (!(IsAdministrator))
{
    if (IsUacEnabled)
    {
        [string[]]$argList = @('-NoProfile', '-NoExit', '-File', $MyInvocation.MyCommand.Path)
        $argList += $MyInvocation.BoundParameters.GetEnumerator() | Foreach {"-$($_.Key)", "$($_.Value)"}
        $argList += $MyInvocation.UnboundArguments
        Start-Process PowerShell.exe -Verb Runas -WorkingDirectory $pwd -ArgumentList $argList 
        return
    }
    else
    {
        throw "You must be administrator to run this script"
    }
}

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

$StartUp="$Env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
New-Item -ItemType SymbolicLink -Path "$StartUp" -Name $filename -Value $filepath
