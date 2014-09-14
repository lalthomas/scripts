@echo OFF
REM ======================================
REM Author : Lal Thomas
REM Email  : lal.thomas.mail@gmail.com
REM ======================================
@echo OFF
REM Display Checklist 
echo ============
echo Check List
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