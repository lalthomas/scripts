@echo OFF
setlocal
cd "%~dp1"
for /f "tokens=*" %%a in ( %~n1%~x1 ) do (  
  start explorer "%%a"
)
endlocal

REM This will start explorer with a folder
REM start explorer "D:\Dropbox\action\20150716-contacts"
REM This will start explorer++ with a list of folders
REM "D:\PortableApps.com\PortableApps\Explorer++Portable\Explorer++Portable.exe" "D:\Dropbox\action\20150716-contacts" "D:\Dropbox\action\20140915-playlist"

