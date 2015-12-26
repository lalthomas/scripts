@echo OFF
setlocal
setlocal enabledelayedexpansion

set /p _ext=Enter the extension :

for %%a in ( %* ) do (  
  
  %%~da
  cd "%%~pa"  
  ren "%%~na%%~xa" "%%~na.%_ext%"

)

exit \b 0
endlocal