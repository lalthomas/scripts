@echo OFF
REM ****************************************************
REM Script to get the attributes of file
for /f "skip=5 tokens=1-8 delims=/: " %%a in ('dir /tc %1') do (
     set mon=%%a      
     set day=%%b
     set yyyy=%%c
     set hh=%%d
     set min=%%e
     set filename=%%h
     goto label
)
:label
REM Replaces all empty space
set mon=%mon: =%
echo %mon% %day% %yyyy% %hh% %min% %filename%
REM ****************************************************
set path=%PATH%;%~dp1
%~d1
cd %~p1

REM ****************************************************
REM Script to get the last folder in the file path
REM Credit : http://stackoverflow.com/questions/2396003/get-parent-directory-name-for-a-particular-file-using-dos-batch-scripting
@echo OFF

setlocal
set ParentDir=%~p1
set ParentDir=%ParentDir: =:%
set ParentDir=%ParentDir:\= %
call :getparentdir %ParentDir%
set ParentDir=%ParentDir::= %
echo ParentDir is %ParentDir%
goto :MAKE_FOLDER

:getparentdir
if "%~1" EQU "" goto :MAKE_FOLDER
Set ParentDir=%~1
shift
goto :getparentdir

REM End of Script
REM ****************************************************


:MAKE_FOLDER 
set timestamp=%yyyy%%mon%%day%

set /a s=2
:CHECKPOINT
	if EXIST "%timestamp%-%ParentDir%-%%~n1 %s%%~x1" (goto MORE)
	goto CONT
	:MORE	
	set /a s=s+1	
goto CHECKPOINT

:CONT
REN "%~n1%~x1" "%timestamp%-%ParentDir%-%~n1%~x1"

REM pause


