@echo OFF
setlocal
REM batch script to add create file
REM Author Lal Thomas
REM Date : 2016-02-16

REM get the script folder path
setlocal ENABLEDELAYEDEXPANSION
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%
%~d1
cd %~dp1
if exist %1 ( 
	"C:\Program Files (x86)\Notepad++\notepad++.exe" %1 
	exit
)
set /p _Opt="do you want to create file %1 (y/n) :"	
IF /I "%_Opt%" == "y" ( 	
REM create file
copy nul %1
"C:\Program Files (x86)\Notepad++\notepad++.exe" %1
)
REM pause
exit /b 0