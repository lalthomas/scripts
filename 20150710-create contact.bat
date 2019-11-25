@echo OFF
setlocal
REM Author Lal Thomas
REM Date 2015-07-10
Setlocal EnableDelayedExpansion

%~d1
cd %1

set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%
 
REM Thanks http://stackoverflow.com/a/19706067/2182047
REM Original modified for need
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "longdatestamp=%YYYY%-%MM%-%DD%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

set copyfilename="D:\do\support\20140618-home support template-contact card.md"
set /p name="enter contact name : "
set /p namelower="enter contact name in lowercase : "
set /p circle="enter the circle : "
set /p birthday="enter birthday (YYYY-MM-DD) : "
set /p homephonenumber="enter home phone number : "
set /p email="enter email : "
set /p facebookid="enter facebook ID : "


set commitmessage="update the contact details of %namelower%"
REM remove quotes
set commitmessage="%commitmessage:"=\"%"

set filename=%datestamp%-%namelower% contact file.md
set fullfilepath="%CD%\%filename%"

REM call create file routine
call "%scriptFolderPath%\20160827-create file-dos batch script.bat" %fullfilepath%

IF %ERRORLEVEL% EQU 0 ( 
	
	type %copyfilename% >> %fullfilepath%
	call "%scriptFolderPath%\tools\fart\fart.exe" %fullfilepath% "$LONGDATE$" "%longdatestamp%" >nul 2>nul
	call "%scriptFolderPath%\tools\fart\fart.exe" %fullfilepath% "$NAME$" "%name%" >nul 2>nul
	call "%scriptFolderPath%\tools\fart\fart.exe" %fullfilepath% "$BIRTHDAY$" "%birthday%" >nul 2>nul
	call "%scriptFolderPath%\tools\fart\fart.exe" %fullfilepath% "$NUMBER01$" "%homephonenumber%" >nul 2>nul
	call "%scriptFolderPath%\tools\fart\fart.exe" %fullfilepath% "$EMAIL$" "%email%" >nul 2>nul
	call "%scriptFolderPath%\tools\fart\fart.exe" %fullfilepath% "$FB_ID$" "%facebookid%" >nul 2>nul
	call "%scriptFolderPath%\tools\fart\fart.exe" %fullfilepath% "$CIRCLE$" "%circle%" >nul 2>nul
	
	REM add to revision control	
	call git add %fullfilepath% >nul 2>nul
	call git commit -m %commitmessage% >nul 2>nul	
	
	IF %ERRORLEVEL% EQU 0 ( 		
		echo SUCCESS : %filename% successfully updated and commited	
		"%PROGRAMFILES%\Notepad++\notepad++.exe" %fullfilepath%		
	) ELSE ( 		
		echo ERROR : %filename%  is either not updated or commited 		
	)
	
) ELSE (

	echo ERROR : %filename%  is either not created or commited	
	exit /b 1
	
)


:end

REM add inbox
echo %longdatestamp% %fullfilepath% >>"D:\do\inbox.txt"

REM add to contact list
REM "Filename","Circle","Relation","Inbox","Home Town","Work Town","Mobile","Email"
echo %fullfilepath%,"%circle%","","","","">>"D:\do\reference\20161217-lalthomas contact list.csv"

exit /b 0
endlocal
REM pause
