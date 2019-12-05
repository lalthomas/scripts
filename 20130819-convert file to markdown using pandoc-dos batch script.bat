@echo OFF
setlocal
set path=%PATH%;
call pandoc -S %1 -o "%~d1%~p1%~n1.md"
REM pause
endlocal