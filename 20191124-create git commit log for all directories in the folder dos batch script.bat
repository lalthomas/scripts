@echo OFF
pushd %1
set runfile="FILEPATH"
for /f "tokens=*" %%f in ('dir /a:D /b /O:N') do  call :gitcommitlog "%%f" "%CD%"
popd
exit /b 0
pause

:gitcommitlog
pushd %1
set OUTFILE="%~2\git status log.txt"
echo.>>%OUTFILE%
echo %~1 >>%OUTFILE%
echo ------- >>%OUTFILE%
git status --short >>%OUTFILE%
popd
exit /b 0