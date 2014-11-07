@echo OFF
setlocal
set path=%PATH%;%CD%
REM copy %1 "E:\Temp\Backup\Arch%~x1"
md "%~n1"
move %1 "%CD%\%~n1"
endlocal