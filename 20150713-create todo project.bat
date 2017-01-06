@echo OFF
setlocal
REM Author Lal Thomas (lal.thomas.mail@gmail.com)
REM get the script folder path
REM 2015-07-13

%~d1
cd %1
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%
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
call :VERIFY %projectname%

set copyfilename="D:\Dropbox\do\support\20150619-home support template-todo project doc.md"

set filename=%projectname:+=%
set filename=%filename:\= %
set filename=%filename:/= %
REM dont change the below two lines order
set todofile="%datestamp%-%filename%.txt"
set filename="%datestamp%-%filename% readme.md"

call :PROJECTTYPE

REM generate file from the template 
type %copyfilename% >> %filename%

REM template values
set path="%scriptFolderPath%\tools\fart"
fart -qC %filename% "PROJECTNAME" "%projectname%" 2> nul
fart -qC %filename% "DATE" "%longdatestamp%" 2> nul
start explorer %filename%
REM pause
endlocal
exit

:verify
if [%1]==[] ( 
set /p projectname="enter project name:"
)
exit /b 0


:PROJECTTYPE

REM upcoming type
set /p upcoming="is this project upcoming (y/n)?"
IF /I "%upcoming%" == "y" ( 				
	cd upcoming
	echo %projectname%>%todofile%	
	exit /b 0
) 

REM archive type
set /p archived="is this project archived (y/n)?"	
IF /I "%archived%" == "y" ( 
	cd archive	
	echo %projectname%>%todofile%
	exit /b 0
) 	

REM hold type
set /p hold="is this project on hold (y/n)?"		
IF /I "%hold%" == "y" ( 
	cd hold
	echo %projectname%>%todofile%
	exit /b 0
)	

exit /b 0


