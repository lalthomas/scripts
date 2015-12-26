@echo ON
setlocal
for %%a in ( %* ) do (  

  echo file : %%~na
  echo file drive : %%~da
  echo file folder path : %%~dpa
  echo .
  
  %%~da
  cd "%%~pa"
  dir
  
)
endlocal
pause