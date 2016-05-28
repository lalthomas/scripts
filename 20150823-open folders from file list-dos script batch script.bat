@echo OFF
setlocal
cd "%~dp1"
set "filename=%~dpnx1"
for /f "tokens=*" %%a in ( 'type "%filename%"' ) do (  
  echo %%a | findstr /r "^\#" >nul && ( echo . ) || ( start explorer "%%a" )    
)
endlocal