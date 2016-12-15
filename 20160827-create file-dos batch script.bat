@echo OFF
setlocal
REM batch script to create file
REM Author Lal Thomas
REM Date : 2016-02-16

REM get the script folder path
setlocal ENABLEDELAYEDEXPANSION
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

REM put the path on stack
pushd "%CD%"

if [%1]==[] (

	echo.
	set /p filename="enter file name:" 
	
) else (

	set filename=%1
)

set file=%filename%
set filepath="%CD%\%file%"
REM remove extra quotes
set filepath=%filepath:"=%
REM add quotes around
set filepath="%filepath%"
REM echo %filepath%
REM pause

REM commit message
set commitmessage=%file:"=\"%
set commitmessage="add file %commitmessage%"

REM existing file check
if exist %filepath% ( 
	
	"C:\Program Files (x86)\Notepad++\notepad++.exe" %filepath%
	popd
	goto :end
)

REM confirm
echo.
set /p _Opt="do you want to create file %filepath% (y/n) :"	

IF /I "%_Opt%" == "y" ( 	
	
	REM create file
	copy nul %filepath% >nul 2>nul
	"C:\Program Files (x86)\Notepad++\notepad++.exe" %filepath%	
	REM	if no argument then add to readme
	if [%1]==[] ( call :readmelog %filepath% )	
	REM add to revision control
	git add %filepath% >nul 2>nul
	git add readme.md >nul 2>nul
	git commit -m %commitmessage% >nul 2>nul
	echo.
	IF %ERRORLEVEL% EQU 0 ( 
		echo SUCCESS : %file% successfully created and commited
	) ELSE (	
		echo ERROR : %file%  is either not created or commited
	)	
)

popd
REM pause
goto :end

REM add file to readme file index
:readmelog
echo %1 >> "readme.md"
exit /b 0

REM end of program
:end