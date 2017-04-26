@echo OFF
REM Author : Lal Thomas
REM Date : 2017-04-26
setlocal

REM filelist is passed as the first argument
set filelist=%1
REM echo %*

REM select all parameters after first argument
set /a count=1
setlocal ENABLEDELAYEDEXPANSION
for %%f in (%*) do (			
	call :additem !count! %%f
	set /a count=count+1
)

REM TODO
REM open the list
goto :end


:additem
set /a count=%1
set file=%~2
if NOT %count% EQU 1 ( echo %file% >> %filelist% ) 
exit /b 0

REM pause
REM program end
:end