@echo off

REM Author Lal Thomas
REM Date 2015-07-10

Setlocal EnableDelayedExpansion

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

set filename="%datestamp%-%namelower%.md"
type %copyfilename% >> %filename%
call "%scriptFolderPath%\tools\fart\fart.exe" "%filename%" "$LONGDATE$" "%longdatestamp%"
call "%scriptFolderPath%\tools\fart\fart.exe" "%filename%" "$NAME$" "%name%"
call "%scriptFolderPath%\tools\fart\fart.exe" "%filename%" "$BIRTHDAY$" "%name%"
call "%scriptFolderPath%\tools\fart\fart.exe" "%filename%" "$NUMBER01$" "%name%"
call "%scriptFolderPath%\tools\fart\fart.exe" "%filename%" "$EMAIL$" "%name%"
call "%scriptFolderPath%\tools\fart\fart.exe" "%filename%" "$URL01$" "%name%"

REM Open the file
%filename%
