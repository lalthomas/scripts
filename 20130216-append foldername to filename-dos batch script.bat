@echo OFF
setlocal
setlocal enabledelayedexpansion

set ParentDir=""

for %%a in ( %* ) do (  

  %%~da
  cd "%%~pa"    
  REM echo file : %%~na
  REM echo file drive : %%~da
  REM echo file folder path : %%~dpa
  REM echo .  
  set ParentDir=%%~dpa
  REM echo ParentDir # is !ParentDir!
  set ParentDir=!ParentDir: =:!
  set ParentDir=!ParentDir:\= !
  call :getparentdir !ParentDir!
  set ParentDir=!ParentDir::= !
  REM echo ParentDir ## is !ParentDir!
  REM pause    
  REN "%%~na%%~xa" "%%~na !ParentDir!%%~xa"
  REM echo LOOP END..
  REM pause    
  
)

exit \b 0

REM -----------------------

:getparentdir
REM echo argument : %1
if "%~1" EQU "" ( goto end )
set ParentDir=%~1
shift
goto :getparentdir
:end
REM -----------------------
