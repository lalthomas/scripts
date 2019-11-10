set dropitdir="E:\Portable App\dropit v8.2 portable"
pushd %dropitdir%

REM --- Start of USERPROFILE Data Management ---

echo organize
explorer "%USERPROFILE%\Pictures"
pause

DropIt.exe -year_date_taken "%USERPROFILE%\Pictures"

REM run remaining files with USERPROFILE
DropIt.exe -year_date_taken "%USERPROFILE%\*"

REM Backup
DropIt.exe -backup "%USERPROFILE%\*"
DropIt.exe -backup "C:\cygwin64\home\*"

REM --- END of USERPROFILE Data Management ---

popd