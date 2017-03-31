@echo OFF 	
REM File : 20160806-open supporting file-dos batch script run.bat 	
REM Creation Date : 2017-03-31 	
REM Author : Lal Thomas 	
REM Original File : D:\Dropbox\project\20131027-scripts project\20160806-open supporting file-dos batch script.bat 	
	

IF [%1] == [] GOTO :SETFILE
set file=%1
GOTO :EXECUTE

:SETFILE
set file=$FULLPATH$
GOTO :EXECUTE

REM Section
:EXECUTE
call :COMPILE %file%
call :OUTPUT %file%
exit

REM Sub Routine
:COMPILE

exit /b 0

:OUTPUT
explorer "build\%~nx1"
exit /b 0
