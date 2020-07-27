@echo on
REM Author Lal Thomas <lal.thomas.mail@gmail.com>
REM Date 2015-09-06
set path="%PATH%;%CD%
for %%a in (*.txt) do ( echo %%~a1>>"%%a" )
pause