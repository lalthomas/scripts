@echo OFF 	
setlocal enabledelayedexpansion
REM File : 20170722-move n lines of a file and append to another file-powershell script run.bat 	
REM Creation Date : 2017-07-22 	
REM Author : Lal Thomas 	
REM Original File : 20170722-move n lines of a file and append to another file-powershell script.ps1 	
REM get the script folder path
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%
	
REM Section
REM echo %1
REM echo %2
call "%scriptFolderPath%\20170722-run powershell file-dos batch script.bat" "%scriptFolderPath%\20170722-move n lines of a file and append to another file-powershell script.ps1" "-sourcefile '%1' -destinationfile '%2' -limit '%3'"
endlocal
