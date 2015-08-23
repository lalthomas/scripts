@echo off

REM Author Lal Thomas <lal.thomas.mail@gmail.com>
REM Date LONGDATE

Setlocal EnableDelayedExpansion

REM Thanks http://stackoverflow.com/a/19706067/2182047
REM Original modified for need
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "longdatestamp=%YYYY%-%MM%-%DD%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

set copyfilename="D:\Dropbox\support\20150619-home support template-todo project doc.md"
set /p projectname="enter project name:"

set filename="%datestamp%-%projectname%-project doc.md"
type %copyfilename% >> %filename%
echo %projectname% >> %filename%