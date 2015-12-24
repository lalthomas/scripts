@echo ON
setlocal
cd "%~dp1"
for /f "tokens=*" %%a in ( %~n1%~x1 ) do (  

  echo."%%a" | findstr /C:"# ">nul && ( echo %%a skipped ) || ( start explorer "%%a" )
 
)
pause
endlocal