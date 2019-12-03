@echo OFF 	
REM File : 20170102-create shortcut in sendto folder-powershell script run.bat 	
REM Creation Date : 2017-01-17 	
REM Author : Lal Thomas	
	
setlocal
%~d0
cd %~p0
call :createShortCut %1 %2 %3
endlocal
exit /b 0

:createShortCut
set scriptfile=".\20170102-create shortcut in sendto folder-powershell script.ps1"
IF [%3] == [] (
	powershell -STA -executionpolicy bypass -File %scriptfile% -filename %1 -linkname %2 
) ELSE (
	powershell -STA -executionpolicy bypass -File %scriptfile% -filename %1 -linkname %2 -switch %3
)
exit /b 0