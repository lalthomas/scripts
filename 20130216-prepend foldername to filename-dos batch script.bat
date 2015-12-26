@echo OFF
setlocal
setlocal enabledelayedexpansion

set ParentDir=""

for %%a in ( %* ) do (  

  %%~da
  cd "%%~pa"    

  echo file : %%~na
  echo file drive : %%~da
  echo file folder path : %%~dpa
  echo .
  
  set ParentDir=%%~dpa
  echo ParentDir # is !ParentDir!
  set ParentDir=!ParentDir: =:!
  set ParentDir=!ParentDir:\= !
  call :getparentdir !ParentDir!
  set ParentDir=!ParentDir::= !
  echo ParentDir ## is !ParentDir!
  pause
    
  REN "%%~na%%~xa" "!ParentDir!-%%~na%%~xa"
  
  echo LOOP END..
  pause    
  
)

exit \b 0

REM -----------------------

:getparentdir
echo argument : %1
if "%~1" EQU "" ( goto end )
set ParentDir=%~1
shift
goto :getparentdir
:end