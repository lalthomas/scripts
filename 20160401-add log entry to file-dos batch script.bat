@echo OFF
REM Batch file to add to inbox.md file on do folder
REM Lal Thomas
REM 2016-04-01

REM thanks http://www.simplehelp.net/2008/10/20/launchy-basic-weby-tricks-and-appending-to-a-text-file/
REM Thanks http://stackoverflow.com/a/19706067/2182047
REM Original modified for need
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%-%MM%-%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "longdatestamp=%YYYY%-%MM%-%DD%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

REM filname is passes as first argument
set file=%1

REM Get all parameters but not first
REM Thanks http://stackoverflow.com/a/761658/2182047
shift
set params=%1
:loop
shift
if [%1]==[] goto afterloop
set params=%params% %1
goto loop
:afterloop

REM echo to file
echo %datestamp% %params%>>%file%

exit