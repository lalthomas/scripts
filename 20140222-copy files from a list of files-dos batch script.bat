@echo OFF
setlocal
REM argument one - filename of file list, name shouldn't contain space
REM argument two - destinaton folder
set dst_folder="%~2"
REM  Loop through the filelist
%~d1
cd %~dp1

echo copying files ...
for /f "usebackq tokens=* delims=" %%a in ( `type %1` ) do (
	xcopy "%%~dpna.*" %dst_folder% >nul 2>nul
)

REM pause
endlocal
