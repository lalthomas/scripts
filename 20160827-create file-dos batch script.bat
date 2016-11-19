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
set filename=%1
set commitmessage=%filename:"=\"%
set commitmessage="add %commitmessage% file"

if exist %filename% ( 
	"C:\Program Files (x86)\Notepad++\notepad++.exe" %filename%
	exit
)
set /p _Opt="do you want to create file %filename% (y/n) :"	
IF /I "%_Opt%" == "y" ( 	
REM create file
copy nul %filename%
"C:\Program Files (x86)\Notepad++\notepad++.exe" %filename%
REM add to revision control
git add %filename% "readme.md"
git commit -m %commitmessage%
)

REM pause
exit /b 0