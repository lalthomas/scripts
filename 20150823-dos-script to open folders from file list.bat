@echo OFF
setlocal
cd "%~dp1"
for /f "tokens=*" %%a in ( %~n1%~x1 ) do (  
  start explorer "%%a"
)
endlocal

