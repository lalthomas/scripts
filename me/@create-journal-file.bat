@echo off

REM Author Lal Thomas
REM Date 2014-07-02
Setlocal EnableDelayedExpansion
set localdatetime
set COPYDIR="D:\Dropbox\docs"

REM Thanks http://stackoverflow.com/a/19706067/2182047
REM Orginal modified for need
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "longdatestamp=%YYYY%-%MM%-%DD%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
REM echo datestamp: "%datestamp%"
REM echo timestamp: "%timestamp%"
REM echo fullstamp: "%fullstamp%"

REM Thanks http://support.mogware.net/index.php?topic=930.0
REM Generate journal based on day of week

for /f %%a in ('date /t') do set DAY=%%a

if %DAY%==Mon goto :mon
if %DAY%==Tue goto :tue
if %DAY%==Wed goto :wed
if %DAY%==Thu goto :thu
if %DAY%==Fri goto :fri
if %DAY%==Sat goto :sat
if %DAY%==Sun goto :sun

:mon
:: put your processing here
set filename="%datestamp%-monday personal journal.md"
set copyfilename=planner-01-monday.md
GOTO CONTINUE

:tue
:: put your processing here
set filename="%datestamp%-tuesday personal journal.md"
set copyfilename=planner-02-tuesday.md
GOTO CONTINUE

:wed
:: put your processing here
set filename="%datestamp%-wednesday personal journal.md"
set copyfilename=planner-03-wednesday.md
GOTO CONTINUE

:thu
:: put your processing here
set filename="%datestamp%-thursday personal journal.md"
set copyfilename=planner-04-thursday.md
GOTO CONTINUE

:fri
:: put your processing here
set filename="%datestamp%-friday personal journal.md"
set copyfilename=planner-05-friday.md
GOTO CONTINUE

:sat
:: put your processing here
set filename="%datestamp%-saturday personal journal.md"
set copyfilename=planner-06-saturday.md
GOTO CONTINUE

:sun
:: put your processing here
set filename="%datestamp%-sunday personal journal.md"
set copyfilename=planner-07-sunday.md
GOTO CONTINUE

:CONTINUE

if EXIST %COPYDIR%\%filename% ( GOTO EXIT )

echo %datestamp% >%filename%
REM add a blank line and markdown heading 1 label
echo ^======== >>%filename%  

REM add a blank line
echo. >>%filename%

echo Scheduled Tasks >>%filename%
REM add markdown heading 2 label
echo ^-------------- >>%filename%  

REM add a blank line
echo. >>%filename%

REM Dump the today's scheduled task to todo.txt
findstr /B /C:%longdatestamp% calendar.txt >> %filename%

REM copy the planner template file
type %copyfilename% >> %filename%

move %filename% %COPYDIR%

:EXIT

REM open file
%COPYDIR%\%filename%
