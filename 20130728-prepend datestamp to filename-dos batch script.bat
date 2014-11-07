@echo OFF
REM ****************************************************
REM Script to get the attributes of file
for /f "skip=5 tokens=1-8 delims=/: " %%a in ('dir /tC %1') do (
     set mon=%%a      
     set day=%%b
     set yyyy=%%c
     set hh=%%d
     set min=%%e
     set filename=%%h
     goto label
)
:label
REM %mon% %day% %yyyy% %hh% %min% %filename%
REM Replaces all empty space
set mon=%mon: =%
set time=%yyyy%%mon%%day%
echo %time%
REM pause
REM goto :EOF
REM ****************************************************

REN "%~n1%~x1" "%time%-%~n1%~x1"

REM pause
