@echo OFF

REM Author Lal Thomas
REM Date 2015-07-10
Setlocal EnableDelayedExpansion

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

set copyfilename="D:\Dropbox\support\20140618-home support template-contact card.md"
set /p name="enter contact name : "
set /p namelower="enter contact name in lowercase : "
set /p birthday="enter birthday (YYYY-MM-DD) : "
set /p homephonenumber="enter home phone number : "
set /p email="enter email : "
set /p facebookurl="enter facebook url : "

set filename=%datestamp%-%namelower%.md
set fullfilepath="%CD%\%filename%"
type %copyfilename% >> %fullfilepath%
call "%scriptFolderPath%\tools\fart\fart.exe" %fullfilepath% "$LONGDATE$" "%longdatestamp%"
call "%scriptFolderPath%\tools\fart\fart.exe" %fullfilepath% "$NAME$" "%name%"
call "%scriptFolderPath%\tools\fart\fart.exe" %fullfilepath% "$BIRTHDAY$" "%birthday%"
call "%scriptFolderPath%\tools\fart\fart.exe" %fullfilepath% "$NUMBER01$" "%homephonenumber%"
call "%scriptFolderPath%\tools\fart\fart.exe" %fullfilepath% "$EMAIL$" "%email%"
call "%scriptFolderPath%\tools\fart\fart.exe" %fullfilepath% "$URL01$" "%facebookurl%"

REM Open the file
%fullfilepath%
