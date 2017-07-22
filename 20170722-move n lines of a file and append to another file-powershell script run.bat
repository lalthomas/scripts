@echo OFF 	
REM File : 20170722-move n lines of a file and append to another file-powershell script run.bat 	
REM Creation Date : 2017-07-22 	
REM Author : Lal Thomas 	
REM Original File : 20170722-move n lines of a file and append to another file-powershell script.ps1 	
	
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
set file="D:\Dropbox\project\20131027-scripts project\20170722-move n lines of a file and append to another file-powershell script.ps1"
GOTO :EXECUTE

REM Section
:EXECUTE
call :COMPILE %file%
call :OUTPUT %file%
exit

REM Sub Routine
:COMPILE
REM remove the original date string and add the current
set "filename=%~n1"
set "filename=%filename:~9%"
set "filename=%datestamp%-%filename%"
REM invoke the compiler
REM pandoc "%~1" -o ".\build\%filename%.pdf"

exit /b 0

:OUTPUT
REM invoke the build file
REM explorer "build\%filename%.pdf"
exit /b 0
