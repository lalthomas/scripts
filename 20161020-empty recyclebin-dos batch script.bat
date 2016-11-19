@ECHO OFF
REM thanks http://stackoverflow.com/a/21111992/2182047
start /b /wait powershell.exe -command "$Shell = New-Object -ComObject Shell.Application;$RecycleBin = $Shell.Namespace(0xA);$RecycleBin.Items() | foreach{Remove-Item $_.Path -Recurse -Confirm:$false}"