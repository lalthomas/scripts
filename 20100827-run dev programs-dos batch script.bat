@echo OFF
REM Author Lal Thomas <www.lalamboori.blogspot.in>
REM 
setlocal

%~d1
cd "%~p1"

REM get the script folder path
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

set filename=%~n1 run.bat
set filename="%filename%"
set runcmd=%filename% %1

if exist %filename% (
	%runcmd%	
	exit
)

set IISPATH="C:\inetpub\wwwroot\"
set JAVAPATH="C:\Program Files\Java\jdk1.7.0_51\bin"
set PYTHON3="C:\Users\admin\AppData\Local\Programs\Python\Python35"
set PYTHON2="C:\Python27"
set FIREFOX="%ProgramW6432%\Mozilla Firefox\firefox.exe"

if /i %~x1 == .html ( goto HTML)
if /i %~x1 == .java ( goto JAVA )
if /i %~x1 == .class ( goto JAVA )
if /i %~x1 == .jar ( goto JAVAJAR )
if /i %~x1 == .md ( goto PHP )
if /i %~x1 == .php ( goto PHP )
if /i %~x1 == .sql ( goto SQL )
if /i %~x1 == .py ( goto PYTHON )
if /i %~x1 == .sh ( goto BASH )
if /i %~x1 == .r ( goto R )
if /i %~x1 == .ps1 ( goto POWERSHELL )
if /i %~x1 == .c ( goto C)
if /i %~x1 == .cpp ( goto C)

goto END


:C
set path=%PATH%;%CD%
start cmd /k "%~n1.exe"
REM pause
goto END

REM HTML
:html
set path=%PATH%;%CD%
call %FIREFOX% "%~n1%~x1"
pause
exit

REM Java
:JAVA
@echo OFF
setlocal
set path=%PATH%;%JAVAPATH%
REM check whether the file is an applet
REM thank you : http://stackoverflow/a/21072632
echo."%~n1" | findstr /c:"applet">nul && (
REM "Assuming this is an applet since applet name found"
set appletFile=%~n1-applet.html
echo ^<html^>^<head^>AppletViewer^<^/head^>^<body^>^<applet code^="%~n1" width^=500 height^=500^>^<^/applet^>^<^/body^>^<^/html^> >%~n1-applet.html
call appletviewer %~n1-applet.html
) || (
rem this is commandlline
call java "%~n1"
)
REM pause
goto END

:JAVAJAR
@echo OFF
setlocal
set path=%PATH%;%JAVAPATH%
call java -jar "%1"
goto END

REM PHP
:PHP
@echo OFF
setlocal
set OrginalPath=%CD%
set ParentDir=%~p1
REM this reduce the 
call :getParentFolderName

REM create temporary batch file for running as adminstrator
if not exist temp.bat (
echo C:>temp.bat
echo cd %IISPATH%>>temp.bat
echo mklink /d "%ParentDir%" "%OrginalPath%">>temp.bat
echo del temp.bat>>temp.bat
)

REM change the path
C:
cd %IISPATH%

if not exist "%ParentDir%" ( 
echo "%OrginalPath%\temp.bat"
REM invoke the adminstrator dialog box
Powershell -Command "& {Start-Process" \"%OrginalPath%\\temp.bat\"-verb RunAs}"
)

call %FIREFOX% "http://localhost/%ParentDir%/%~n1%~x1"
del "%OrginalPath%\temp.bat"
goto END


:SQL
@echo OFF
setlocal
set path=%PATH%;C:\Program Files\MySQL\MySQL Server 5.1\bin
SET /p _Opt="Are you sure to restore the database (y/n) : " 
IF "%_Opt%" == "n" ( goto :EOF)
set username=root
set password=tiger
mysql -u%username% -p%password% <%1
pause
goto END


:PYTHON
@echo OFF
echo %1

REM Python 2
REM set path=%PATH%;%PYTHON2%
REM call %PYTHON2%\python %1

REM Python 3
REM set path=%PATH%;%PYTHON3%
REM call %PYTHON3%\python %1

call %PYTHON% %1
pause
goto END

REM BASH
:bash
@echo OFF
set path=%PATH%;%CD%
call C:\cygwin64\bin\bash.exe -l -c "ags=\"$@\"; IFS=';' read -ra paths <<< \"$ags\"; cd \"${paths[0]}\"; \"./${paths[1]}\";  read -rsp $'Press any key to continue...\n' -n 1 key; " " " "%~dp1;%~nx1"
REM call C:\cygwin64\bin\bash.exe %1 && pause
exit


REM R Language
:R
@echo OFF
call "C:\Program Files\R\R-3.3.0\bin\Rscript.exe" %1
pause
exit

:POWERSHELL
@echo OFF
set path=%PATH%;%CD%
REM For running options see [.net - Could you explain STA and MTA? - Stack Overflow](http://stackoverflow.com/questions/127188/could-you-explain-sta-and-mta)

REM Mutlithreaded
REM powershell -MTA -executionpolicy bypass -File ".\%~nx1"

REM Single Threaded
powershell -STA -executionpolicy bypass -File ".\%~nx1"
REM pause
exit


:getParentFolderName
REM thanks : http://stackoverflow.com/questions/2396003/get-parent-directory-name-for-a-particular-file-using-dos-batch-scripting
set ParentDir=%ParentDir: =:%
set ParentDir=%ParentDir:\= %
call :getparentdir %ParentDir%
set ParentDir=%ParentDir::= %


:getparentdir
if "%~1" EQU "" goto END
set ParentDir=%~1
shift
goto :getparentdir

pause
:END
endlocal


