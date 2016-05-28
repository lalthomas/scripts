@echo ON
REM ======================================
REM Author : Lal Thomas
REM Email  : lal.thomas.mail@gmail.com
REM ======================================
@echo OFF
REM Display Checklist 
echo ============
echo %~n1.%~x1
echo ============
REM Thanks : http://stackoverflow.com/q/134001
SetLocal EnableDelayedExpansion
set path=%PATH%;%CD%
for /F "delims=" %%i in (%1) do (
echo %%i
set /p CHECKED=
)
exit
REM @%COMSPEC% /C exit 1 >nul