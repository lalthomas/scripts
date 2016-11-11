@echo off
REM Author Lal Thomas <lal.thomas.mail@gmail.com>
REM Date LONGDATE
%~d1
cd %1

Setlocal EnableDelayedExpansion
REM Thanks http://stackoverflow.com/a/19706067/2182047
REM Original modified for need
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "longdatestamp=%YYYY%-%MM%-%DD%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

:NAME
set /p projectname="enter reference file name:"
set filename="%datestamp%-%projectname%.md"
echo filename : %filename%
SET /p _Opt= Press Y for confirmation or N for retype : 
IF /I "%_Opt%" == "N" ( goto :NAME )

:CREATE
echo %% %projectname% >> %filename%
echo %% Lal Thomas >> %filename%
echo %% %longdatestamp% >> %filename%
echo.>> %filename%
echo.>> %filename%
echo Date		Notes >> %filename%
echo ----------	------------------ >> %filename%

REM add to revision control
git add %filename%
set message=%filename:"=\"%
set message="add %message% file"
git commit -m %message%

REM start the program
start "notepad-pp" %filename%
