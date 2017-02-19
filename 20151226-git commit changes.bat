@echo OFF
REM DOS Batch script to commit changes in folders and files
REM Lal Thomas
REM 2015-12-26

REM This script may give weird error messages if you are working with file with no extensions

setlocal enabledelayedexpansion
set gitPath="C:\Program Files\Git\bin\sh.exe"
REM echo all: %*

REM loop through all arguments
for %%a in ( %* ) do (  
  echo.  
  echo change in : %%a
  call :SHOWCHANGE %%a
  set /p "commitMessage=enter commit message : "
  call :MAP %%a "!commitMessage!"  
)
endlocal

exit /b 0

:SHOWCHANGE
setlocal
IF [%~x1]==[] (
  REM for folder 
  %~d1
  cd "%~1"      
  call %gitPath% --login -i -c "git diff --minimal" "%1"
) ELSE ( 
  REM for file
  %~d1
  cd "%~p1"        
  call %gitPath% --login -i -c "git diff --minimal '%~nx1'" "%~dp1"  
 )
endlocal
exit /b 0


:MAP
setlocal
@echo OFF
set "commitMessage=%2"
REM replace double quotes with single quotes
set commitMessage=!commitMessage:"='!

IF [%~x1]==[] (
  REM for folder 
  %~d1
  cd "%~1"      
  call %gitPath% --login -i -c "git add -A && git commit -am%commitMessage%" "%1"
) ELSE ( 
  REM for file
  %~d1
  cd "%~p1"        
  call %gitPath% --login -i -c "git add '%~nx1' && git commit -m%commitMessage%" "%~dp1"      
 )
endlocal
exit /b 0  