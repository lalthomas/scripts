@echo OFF
set "dst_folder=D:\temp"

REM  Loop through the filelist

set filename=D:\Dropbox\do\reference\20150724-tablet-videos.m3u

for /f "delims=" %%a in  ( %filename% ) do (
if not exist %dst_folder%\"%%~nxa" ( xcopy /c /p  "%%~dpna.*" %dst_folder% )
)
start explorer %dst_folder%

pause