@echo OFF 	
REM File : 20160225-support folder-bash script install.bat 	
REM Creation Date : 2019-11-27 	
REM Author : Lal Thomas 	
REM Original File : 20160225-support folder-bash script.sh 	
	
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
set file="%~dp020160225-support folder-bash script.sh"
GOTO :EXECUTE

REM Section
:EXECUTE
echo source "$(cygpath %file%)">>"C:\cygwin64\home\%USERNAME%\.bash_profile"
REM convert the line ending to unix
call "C:\Program Files\Git\usr\bin\dos2unix.exe" "C:\cygwin64\home\%USERNAME%\.bash_profile"

echo source %file%>>"%USERPROFILE%\.bashrc"
exit /b 0