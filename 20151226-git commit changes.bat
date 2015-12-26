@echo ON

setlocal enabledelayedexpansion
set gitPath="C:\Program Files (x86)\Git\bin\sh.exe"

echo all: %*

for %%a in ( %* ) do (        
  set /p "commitMessage=1 commit message change in %%a : "
  call :MAP %%a "!commitMessage!"
  REM : need to add this line otherwise will run twice
  echo %%a processed
)

:MAP
setlocal
echo argument 1: %1
echo argument 2 : %2

set "commitMessage=%2"
REM replace double quotes with single quotes
set commitMessage=!commitMessage:"='!


IF [%~x1]==[] (

  %~d1
  cd "%~1"
  REM for folder        
  call %gitPath% --login -i -c "git add -A" "%1"
  call %gitPath% --login -i -c "git commit -am%commitMessage%" %1
  exit /b 0
   
) 
endlocal
exit /b 0
  
endlocal
pause