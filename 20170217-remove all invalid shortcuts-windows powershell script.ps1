Function Remove-InvalidStartMenuItem {
    $WshShell = New-Object -comObject WScript.Shell
    # $Files = Get-ChildItem -Path "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" -Filter *.lnk
    $Files = Get-ChildItem -Path "D:\OneDrive\Data\Windows-Appdata-Roaming\Microsoft\Windows\Start Menu\Programs" -Filter *.lnk
    foreach ($File in $Files) {
        $FilePath = $File.FullName
        $Shortcut = $WshShell.CreateShortcut($FilePath)
        $Target = $Shortcut.TargetPath
        if (Test-Path -Path $Target) {
            Write-Output "Valid: $($File.BaseName)"
        } else {
            Write-Output "Invalid: $($File.BaseName) removed."
            try {
              Remove-Item -Path $LnkFilePath
              Write-Output "Removed: $($File.BaseName) removed."
            } catch {
              Write-Output "ERROR: $($File.BaseName) not removed."
            }
        }
    }
}

Remove-InvalidStartMenuItem