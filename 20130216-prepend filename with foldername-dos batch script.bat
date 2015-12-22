@echo OFF
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

set /a s=2
:CHECKPOINT
	if EXIST "%ParentDir%-%%~n1 %s%%~x1" (goto MORE)
	goto CONT
	:MORE	
	set /a s=s+1	
goto CHECKPOINT

:CONT
REN "%~n1%~x1" "%ParentDir%-%~n1%~x1"

REM pause


