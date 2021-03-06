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

REM clean project name
set filename=%projectname:+=%
set filename=%filename:\= %
set filename=%filename:/= %

REM dont change the below two lines order
set todofile="%datestamp%-%filename%.todo"
set filename="%datestamp%-%filename% readme.md"
REM change folder based on project type
call :PROJECTTYPE

REM generate file from the template 
set todoprojecttemplate="D:\do\support\20150619-home support template-todo project doc.md"
type %todoprojecttemplate% >> %filename%

REM replace template values
set path="%scriptFolderPath%\tools\fart"
fart -qC %filename% "PROJECTNAME" "%projectname%" 2> nul
fart -qC %filename% "DATE" "%longdatestamp%" 2> nul

REM add to gtd project list
call :addtolist %filename%
start explorer %filename%
REM pause
endlocal
goto :end

:verify
if [%1]==[] ( 
echo.
set /p projectname="enter project name : "
)
exit /b 0


:PROJECTTYPE
echo.
echo PROJECT TYPES
echo.
echo  current	[enter]
echo  upcoming	[u]
echo  hold 		[h]
echo  archive	[a]
echo.
set /p type="choose the type : "
if /i "%type%"=="u" ( cd upcoming )
if /i "%type%"=="h" ( cd hold )
if /i "%type%"=="a" ( cd archive )
goto endprojecttype

:endprojecttype
exit /b 0

REM -------- END ----------

REM Routine Start
:addtolist
echo %CD%\%~1 >> "D:\do\reference\20161001-gtd project list.txt"
exit /b 0
REM -------- END ----------

:end