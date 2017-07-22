
REM 20170722-run powershell file-dos batch script.bat
REM Lal Thomas (lal.thomas.mail@gmail.com)
REM 2017-07-22

@echo OFF
setlocal 
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

set scriptfile="%scriptFolderPath%\%~nx1"

REM Get all parameters but not first
REM Thanks http://stackoverflow.com/a/761658/2182047
shift
set params=%1
:loop
shift
if [%1]==[] goto afterloop
set params=%params% %1
goto loop
:afterloop
set option=%params%

REM remove double quotes
set option=%option:"=%
REM change single quotes as double quotes
set option=%option:'="%
powershell -STA -executionpolicy bypass -File %scriptfile% %option%
endlocal