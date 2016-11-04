@echo OFF
setlocal
REM batch script to add create file
REM Author Lal Thomas
REM Date : 2016-02-16

REM get the script folder path
setlocal ENABLEDELAYEDEXPANSION
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%
IF [%1]==[ ] ( cd %CD% ) ELSE ( %~d1 && cd %~dp1 ) 
"C:\Program Files (x86)\Notepad++\notepad++.exe" %1
REM if exist %1 ( "C:\Program Files (x86)\Notepad++\notepad++.exe" %1 && exit )
REM set /p _Opt="do you want to create file %1 (y/n) :"	
REM IF /I "%_Opt%" == "y" ( 	
REM REM create file
REM copy nul %1
REM "C:\Program Files (x86)\Notepad++\notepad++.exe" %1
REM )
REM pause