@echo OFF
REM File : 20191129-list all top priotity tasks run.bat 	
REM Creation Date : 2019-11-29 	
REM Author : Lal Thomas 	
REM Original File : 20191129-list all top priotity tasks.sh 	
	
REM Thanks http://stackoverflow.com/a/19706067/2182047
REM Original modified for need
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "longdatestamp=%YYYY%-%MM%-%DD%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

IF [%1] == [] GOTO :SETFILE
set file=%1
GOTO :EXECUTE

:SETFILE
REM set file="D:\temp\20191129-list all top priotity tasks.sh"
set file="%~dp020191129-list all top priotity tasks.sh"
call :EXECUTE %file%

REM Section
:EXECUTE
start /wait /B "%~n1" C:\cygwin64\bin\bash.exe --login -i %1
REM call C:\cygwin64\bin\bash.exe --login -i %1
pause
exit
