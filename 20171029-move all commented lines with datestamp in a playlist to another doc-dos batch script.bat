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
findstr /c:^# %sourcefilepath% | findstr /r /c:"[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]" >> %watchedfilepath%
REM add newline
echo.>> %watchedfilepath%
set path="%scriptFolderPath%\tools\rxfind"
call rxfind %sourcefilepath% /B:2 /P:\n\#\s[0-9]*\s(.*)\r /R:
endlocal