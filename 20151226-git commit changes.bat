@echo OFF

setlocal enabledelayedexpansion
set gitPath="C:\Program Files (x86)\Git\bin\sh.exe"
REM echo all: %*

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
  call %gitPath% --login -i -c "git diff" "%1"
) ELSE ( 
  REM for file
  %~d1
  cd "%~p1"        
  call %gitPath% --login -i -c "git diff '%~nx1'" "%~dp1"  
 )
endlocal
exit /b 0


:MAP
setlocal
REM echo argument 1: %1
REM echo argument 2 : %2

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