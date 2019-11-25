@echo OFF 
setlocal
%~d0
cd %~p0	
REM File : 20161102-aliases for lalthomas pc-dos script support file install.bat 	
REM Creation Date : 2018-08-09 	
REM Author : Lal Thomas 	
REM Original File : 20161102-aliases for lalthomas pc-dos script support file.cmd 	

IF [%1] == [] GOTO :SETFILE
set file=%1
GOTO :EXECUTE

:SETFILE
set "file=%CD%\20161102-aliases for lalthomas pc-dos script support file.cmd"
GOTO :EXECUTE

REM Section
:EXECUTE
set scriptfile=".\20180809-create shortcut on user desktop-powershell script.ps1"
powershell -STA -executionpolicy bypass -File %scriptfile% -filename "cmd.exe" -linkname "cmd+.lnk" -switch "/K \"%file%\""
exit
endlocal
