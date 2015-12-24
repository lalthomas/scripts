@echo OFF
setlocal
cd "%~dp1"
for /f "tokens=*" %%a in ( %~n1%~x1 ) do (  
  echo %%a | findstr /r "^\#" >nul && ( echo . ) || ( start explorer "%%a" )    
)
REM pause
endlocal