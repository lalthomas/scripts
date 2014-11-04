function Rename-FilesToSHA {
    [CmdletBinding()]
    Param(
    [ValidateScript({ Test-Path $_ })]
    $Path
    )

    $hasher = [System.Security.Cryptography.HashAlgorithm]::Create('SHA1')
    $files = Get-ChildItem $Path -Recurse | Where-Object {-not $_.PSIsContainer}

    foreach ($file in $files) {

    $fs = New-Object IO.FileStream($file.FullName, 'Open')
    $sb = New-Object System.Text.StringBuilder

    $hasher.ComputeHash($fs) | ForEach-Object { [void]$sb.Append($_.ToString("x2")) }
    $fs.Close()

    $file | Rename-Item -NewName $sb.ToString()
    }
}