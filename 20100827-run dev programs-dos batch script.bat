@echo OFF
setlocal
if /i %~x1 == .html ( goto HTML)
if /i %~x1 == .java ( goto JAVA )
if /i %~x1 == .class ( goto JAVA )
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

:END
pause
endlocal