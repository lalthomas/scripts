@echo OFF
REM Thanks http://stackoverflow.com/a/19706067/2182047
REM Orginal modified for need
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%-%MM%-%DD%" & set "timestamp=%HH%%Min%%Sec%"

REM Dump the today's scheduled task to todo.txt
findstr /B /C:%datestamp% calendar.txt >> todo.txt
echo Successfully copied the scheduled tasks to todo.txt
pause