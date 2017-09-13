@echo OFF 	
REM File : 20140222-copy files from filelist to a destination folder-bash script run.bat 	
REM Creation Date : 2017-09-13 	
REM Author : Lal Thomas 	
REM Original File : 20140222-copy files from filelist to a destination folder-bash script.sh 	
	
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
set file="D:\Dropbox\project\20131027-scripts project\20140222-copy files from filelist to a destination folder-bash script.sh"
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
