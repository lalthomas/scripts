@echo OFF 	
REM File : 20151117-workflow-bash script install.bat 	
REM Creation Date : 2019-11-27 	
REM Author : Lal Thomas 	
REM Original File : 20151117-workflow-bash script.sh 	
	
REM Thanks http://stackoverflow.com/a/19706067/2182047
REM Original modified for need
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "longdatestamp=%YYYY%-%MM%-%DD%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

IF [%1] == [] GOTO :SETFILE
set file=%1
GOTO :EXECUTE

:SETFILE
set file="%scriptFolderPath%\20151117-workflow-bash script.sh"
GOTO :EXECUTE

REM Section
:EXECUTE
REM cygwin only
echo source "$(cygpath %file%)" "D:\do\reference\20161130-workflow script config file.cfg">>"C:\cygwin64\home\%USERNAME%\.bash_profile"
REM convert the line ending to unix
call "C:\Program Files\Git\usr\bin\dos2unix.exe" "C:\cygwin64\home\%USERNAME%\.bash_profile"

REM echo source %file%>>"%USERPROFILE%\.bashrc"
exit /b 0