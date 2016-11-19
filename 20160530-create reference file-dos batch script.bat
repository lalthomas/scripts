@echo off
REM Author Lal Thomas <lal.thomas.mail@gmail.com>
REM Date LONGDATE
%~d1
cd %1

REM echo %*
Setlocal EnableDelayedExpansion
REM Thanks http://stackoverflow.com/a/19706067/2182047
REM Original modified for need
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "longdatestamp=%YYYY%-%MM%-%DD%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"


REM Get all parameters but not first
REM Thanks http://stackoverflow.com/a/761658/2182047
shift
set params=%1
:loop
shift
if [%1]==[] goto afterloop
set params=%params% %1
goto loop
:afterloop


REM set project name from second argument
set projectname=%params%

:NAME
call :VERIFY %projectname%
set filename="%datestamp%-%projectname%.md"
echo filename : %filename%
set commitmessage=%filename:"=\"%
set commitmessage="add %commitmessage% file"
SET /p _Opt= Press Y for confirmation or N for retype : 

IF /I "%_Opt%" == "N" ( 
	call :VERIFY 
	goto :NAME
) ELSE (
	goto :CONT 
)

:CONT
REM reference file creation

if not exist %filename% ( 
	
	echo %% %projectname% >> %filename%
	echo %% Lal Thomas >> %filename%
	echo %% %longdatestamp% >> %filename%
	echo.>> %filename%
	echo.>> %filename%
	echo Date		Notes >> %filename%
	echo ----------	------------------ >> %filename%
	
	REM lanuch
	call :LAUNCH %filename%	
	
	REM add to revision control
	git add %filename%
	REM git commit -m %commitmessage%
)

REM launch exisitng file
call :LAUNCH %filename%
exit

:VERIFY
if [%1]==[] ( 
set /p projectname="enter reference file name:" 
)
exit /b 0

:LAUNCH
REM start the program
start "notepad-pp" %1
exit /b 0
