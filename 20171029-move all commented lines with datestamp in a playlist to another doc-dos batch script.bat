@echo OFF
setlocal
REM Author Lal Thomas (lal.thomas.mail@gmail.com)
REM move all commented lines with datestamp to another doc
REM 2017-10-29

set sourcefilepath="%~1"
set watchedfilepath="%~2"
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%
Setlocal EnableDelayedExpansion

type %filename% | findstr "# [0-9]*" %sourcefilepath% >> %watchedfilepath%
REM add newline
echo.>> %watchedfilepath%
call "%scriptFolderPath%\tools\fart\fart.exe" %fullfilepath% "$NAME$" "%name%" >nul 2>nul
set path="%scriptFolderPath%\tools\rxfind"
rxfind %sourcefilepath% /B:2 /P:\n\#\s[0-9]*\s(.*)\r /R:

