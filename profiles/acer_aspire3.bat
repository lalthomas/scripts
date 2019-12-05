@echo OFF
setlocal
set dropitdir="E:\Portable App\dropit v8.2 portable"
pushd %dropitdir%

REM --- Start of USERPROFILE Data Management ---

echo organize
explorer "%USERPROFILE%\Pictures"
pause

DropIt.exe -file_year_date_taken "%USERPROFILE%\Pictures\Camera Roll"

REM run remaining files with USERPROFILE
DropIt.exe -file_year_created "%USERPROFILE%\*"

REM Backup
DropIt.exe -backup "%USERPROFILE%\*"
DropIt.exe -backup "C:\cygwin64\home\*"

REM --- END of USERPROFILE Data Management ---

popd
endlocal