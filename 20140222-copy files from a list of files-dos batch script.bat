@echo OFF
setlocal
REM argument one - filename of file list, name shouldn't contain space
REM argument two - destinaton folder
set dst_folder=%2
REM  Loop through the filelist
%~d1
cd %~dp1
for /f "delims=" %%a in ( %~nx1 ) do (
xcopy "%%~dpna.*" %dst_folder%
)
REM pause