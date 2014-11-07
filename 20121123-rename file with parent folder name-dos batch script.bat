@echo OFF
echo Folderize
setlocal
REM ****************************************************
REM Script to get the last folder in the file path (Partial 2)
REM Credit : http://stackoverflow.com/questions/2396003/get-parent-directory-name-for-a-particular-file-using-dos-batch-scripting

setlocal
REM set ParentDir=%~p1
set ParentDir=%CD%
set ParentDir=%~p1
REM echo %ParentDir%

REM Replaces every space with colon
set ParentDir=%ParentDir: =:%
REM echo %ParentDir%

REM Replaces every back slash with space
set ParentDir=%ParentDir:\= %
REM echo %ParentDir%

REM Calls a routine that calculates the last folder
call :getparentdir %ParentDir%

REM Replaces every colon with space
set ParentDir=%ParentDir::= %
REM echo ParentDir is %ParentDir%

REM End of Script (Partial 1) 
REM ****************************************************

REM Code here since there is call command
::REN %1 "[%ParentDir%]-%~n1%~x1"
REN %1 "%ParentDir%%~x1"
REM pause
endlocal

REM ****************************************************
REM Script to get the last folder in the file path (Partial 2)
REM Routine that returns the last word of the string
:getparentdir
if "%~1" EQU "" goto OUT_OF_LASTFOLDER_SCRIPT
Set ParentDir=%~1
shift
goto :getparentdir
:OUT_OF_LASTFOLDER_SCRIPT
REM End of Script
REM ****************************************************

