@echo OFF
setlocal
%~d1
cd %~p1
REM find script folder 
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%
set path="%PATH%;%CD%
for %%a in ("%CD%"\*.*) do ( call "%scriptFolderPath%20130317-convert file to mp4-dos batch script.bat" "%%a" )

REM pause
endlocal