@echo OFF
setlocal

REM get the script folder path
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

set IISPATH="C:\inetpub\wwwroot\site"

if /i %~x1 == .html ( goto HTML)
if /i %~x1 == .java ( goto JAVA )
if /i %~x1 == .class ( goto JAVA )
if /i %~x1 == .php ( goto PHP )
REM Execute Exe,Bat
set path=%PATH%;%CD%
%~d1
cd "%~p1"
call "%~n1"
goto END

REM HTML
:html
set path=%PATH%;%CD%
%~d1
cd "%~p1"
call "%ProgramFiles%\Mozilla Firefox\firefox.exe" "%~n1%~x1"
exit

REM Java
:JAVA
@echo OFF
setlocal
set path=%PATH%;"C:\Program Files\Java\jdk1.5.0\bin"
%~d1
cd "%~p1"
call java "%~n1"
goto END

REM PHP
:PHP
@echo OFF
setlocal
%~d1
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

call "C:\Program Files (x86)\Mozilla Firefox\firefox.exe" "http://localhost/site/%ParentDir%/%~n1%~x1"
del "%OrginalPath%\temp.bat"
goto END


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

:END
endlocal


