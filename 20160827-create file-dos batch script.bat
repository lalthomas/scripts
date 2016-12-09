@echo OFF
setlocal
REM batch script to add create file
REM Author Lal Thomas
REM Date : 2016-02-16

REM get the script folder path
setlocal ENABLEDELAYEDEXPANSION
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%
pushd "%CD%"
set file=%1
set filepath="%CD%\%1"

echo %filepath%

:main
set commitmessage=%file:"=\"%
set commitmessage="add %commitmessage% file"

if exist %filepath% ( 
	"C:\Program Files (x86)\Notepad++\notepad++.exe" %filepath%
	exit
)
set /p _Opt="do you want to create file %filepath% (y/n) :"	
IF /I "%_Opt%" == "y" ( 	
REM create file
copy nul %filepath%
"C:\Program Files (x86)\Notepad++\notepad++.exe" %filepath%
call :readme
call :gitcommit
)
REM pause
popd
exit /b 0

:readme
echo %filepath% >> "readme.md"
exit /b 0

:gitcommit
REM add to revision control
git add "%file%" "readme.md"
git commit -m %commitmessage%
exit /b 0
