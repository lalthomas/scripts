@echo OFF
REM ======================================
REM Author : Lal Thomas
REM Email  : lal.thomas.mail@gmail.com
REM ======================================
@echo OFF
setlocal
echo ===============================
echo Ticket Management System
echo ===============================
set MyAvatar=lalthomas
set MyEmail=lal.thomas.mail@gmail.com
set Project=https://www.assembla.com/spaces/du_3-0
set PROJECTSPACE=du_3-0
set TEAM_MEM_1_EMAIL=arunc@rapidvaluesolutions.com
set TEAM_MEM_2_EMAIL=sminuj@rapidvaluesolutions.com
set TEAM_MEM_3_EMAIL=sujiths@rapidvaluesolutions.com
set TEAM_MEM_4_EMAIL=mouzmip@rapidvaluesolutions.com
set TEAM_MEM_5_EMAIL=

REM Record Time Stamp
REM Timestamp Generator
REM Parse the date (e.g., Fri 02/08/2008)
set cur_yyyy=%date:~10,4%
set cur_mm=%date:~4,2%
set cur_dd=%date:~7,2%
REM Parse the time (e.g., 11:17:13.49)
set cur_hh=%time:~0,2%
if %cur_hh% lss 10 (set cur_hh=0%time:~1,1%)
set cur_nn=%time:~3,2%
set cur_ss=%time:~6,2%
set cur_ms=%time:~9,2%
REM Set the timestamp format
set timestamp=%cur_yyyy%%cur_mm%%cur_dd%-%cur_hh%%cur_nn%%cur_ss%%cur_ms%
set date=%cur_yyyy%%cur_mm%%cur_dd%
set project_current_date=%cur_yyyy%-%cur_mm%-%cur_dd%

REM Prepare Ticket Status Message
echo ^<h1^>%PROJECTSPACE% Ticket Status^</h1^> >temp.tmp
echo ^<p^>Date %date%^</p^> >>temp.tmp

:GET_TICKETS
set TICKET=0
set /p TICKET=Enter the Ticket No (Enter to quit) : 
IF %TICKET%==0 GOTO GOT_TICKETS
//else got some valid ticket
echo ^<h2^>^<a href="%Project%/tickets/%TICKET%#/"^>Ticket #%TICKET%^</a^>^</h2^> >>temp.tmp

echo ^<ul^> >>temp.tmp

set STATUS=1
echo  Enter the status (Return Key : Accepted)
echo  1.Accepted
echo  2.(Skip)
echo  3.Review
echo  4.On Hold
echo  5.Test
echo  6.Fixed
echo  7.Invalid 

set /p STATUS=
if %STATUS%==1 SET STATUS_MSG="Accepted"
if %STATUS%==2 GOTO SKIPSTATUS
if %STATUS%==3 SET STATUS_MSG="Review"
if %STATUS%==4 SET STATUS_MSG="On Hold"
if %STATUS%==5 SET STATUS_MSG="Test"
if %STATUS%==6 SET STATUS_MSG="Fixed"
if %STATUS%==7 SET STATUS_MSG="Invalid"

echo ^<li^>Status: %STATUS_MSG% ^</li^> >>temp.tmp
echo Status: %STATUS_MSG% ^<br/^> >temp2.tmp
echo. >>temp2.tmp
:SKIPSTATUS

set START_DATE=%project_current_date%
echo  Enter the Start Date (YYYY-MM-DD)(Return Key : Today) 
echo  1.Today
echo  2.(Skip)
echo  OR Enter the Date
set /p START_DATE=
if %START_DATE%==1 SET START_DATE=%project_current_date%
if %START_DATE%==2 GOTO SKIP_START_DATE
echo ^<li^>Start Date: %START_DATE% ^</li^> >>temp.tmp
echo Start Date: %START_DATE% ^<br/^> >>temp2.tmp
echo. >>temp2.tmp
:SKIP_START_DATE

set PERSON_ASSIGNED=%MyAvatar%
echo  Enter the assigned person(Return Key : %MyEmail%) 
echo  1.%MyEmail%
echo  2.(Skip)
echo  3.%TEAM_MEM_1_EMAIL%
echo  4.%TEAM_MEM_2_EMAIL%
echo  5.%TEAM_MEM_3_EMAIL%
echo  6.%TEAM_MEM_4_EMAIL%
echo  7.%TEAM_MEM_5_EMAIL%
echo  OR Enter the name
set /p PERSON_ASSIGNED=
if %PERSON_ASSIGNED%==1 SET PERSON_ASSIGNED=%MyEmail%
if %PERSON_ASSIGNED%==2 GOTO SKIP_PERSON_ASSIGNED
if %PERSON_ASSIGNED%==3 SET PERSON_ASSIGNED=%TEAM_MEM_1_EMAIL%
if %PERSON_ASSIGNED%==4 SET PERSON_ASSIGNED=%TEAM_MEM_2_EMAIL%
if %PERSON_ASSIGNED%==5 SET PERSON_ASSIGNED=%TEAM_MEM_3_EMAIL%
if %PERSON_ASSIGNED%==6 SET PERSON_ASSIGNED=%TEAM_MEM_4_EMAIL%
if %PERSON_ASSIGNED%==7 SET PERSON_ASSIGNED=%TEAM_MEM_5_EMAIL%
echo ^<li^>Assigned to: %PERSON_ASSIGNED% ^</li^> >>temp.tmp
echo Assigned to: %PERSON_ASSIGNED% ^<br/^> >>temp2.tmp
echo. >>temp2.tmp
:SKIP_PERSON_ASSIGNED

echo ^</ul^> >>temp.tmp

REM Update indiviadual tickets in Assembla
REM Send Ticket Agenda
REM Thanks : http://stackoverflow.com/q/134001
SetLocal EnableDelayedExpansion
set path=%PATH%;%CD%
set content=
for /F "delims=" %%i in (temp2.tmp) do set content=!content! %%i

set THUNDERBIRD_HOME=C:\Program Files\Mozilla Thunderbird\
echo %date% : updating %TICKET% on Assembla
call "%THUNDERBIRD_HOME%\thunderbird.exe" -compose "to='%PROJECTSPACE%+%TICKET%@tickets.assembla.com',body='%content%',attachment=''"
del temp2.tmp

GOTO GET_TICKETS
:GOT_TICKETS

REM Send Ticket Agenda
REM Thanks : http://stackoverflow.com/q/134001
SetLocal EnableDelayedExpansion
set path=%PATH%;%CD%
set content=
for /F "delims=" %%i in (temp.tmp) do set content=!content! %%i

set THUNDERBIRD_HOME=C:\Program Files\Mozilla Thunderbird\
echo %date% : Preparing Review Mail
call "%THUNDERBIRD_HOME%\thunderbird.exe" -compose "to='%MyEmail%',subject='%date%-Status Update',body='%content%',attachment=''"

del temp.tmp
endlocal
exit