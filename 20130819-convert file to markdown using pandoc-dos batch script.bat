@echo OFF
setlocal
set path=%PATH%;D:\Program Files\Pandoc\bin
call pandoc.exe -S %1 -o "%~d1%~p1%~n1.md"
REM pause
endlocal