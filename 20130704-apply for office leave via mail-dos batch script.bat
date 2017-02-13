@echo OFF

set "THUNDERBIRD=C:\PortableApps.com\PortableApps\ThunderbirdPortable\ThunderbirdPortable.exe"

REM find script folder 
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

set "leaveTemplate=\templates\20141108-leave-template.md"

set path=%PATH%;%~dp1
%~d1
cd %~dp1

REM ======================================
REM Author : Lal Thomas
REM Email  : lal.thomas.mail@gmail.com
REM ======================================
REM Welcome Messge
echo ===============================
echo Welcome to End of Day Program
echo ===============================

set PM_email=
set HR_email=
set Lead_email=

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
set today=%cur_dd%-%cur_mm%-%cur_yyyy%


echo  Enter the Start Date (YYYY-MM-DD)(Return Key : Today) 
echo  1.Today
echo  2.(Skip)
echo  OR Enter the Date
set /p START_DATE=

if %START_DATE%==1 SET START_DATE=%today%
if %START_DATE%==2 GOTO SKIP_START_DATE
echo ^<li^>Start Date: %START_DATE% ^</li^> >>temp.tmp
echo Start Date: %START_DATE% ^<br/^> >>temp2.tmp
echo. >>temp2.tmp
:SKIP_START_DATE

REM Creating Documents...
set path=%path%;C:\Users\Administrator\AppData\Local\Pandoc
pandoc -S "%scriptFolderPath%%leaveTemplate%" -o "temp.html"

REM Update indiviadual tickets in Assembla
REM Send Ticket Agenda
REM Thanks : http://stackoverflow.com/q/134001
SetLocal EnableDelayedExpansion
set path=%PATH%;%CD%
set content=
for /F "delims=" %%i in (temp.html) do set content=!content! %%i
call %THUNDERBIRD% -compose "to='%PM_email%' cc='%HR_email%,%Lead_email%',body='%content%',attachment=''"
del temp.html
del temp.tmp
del temp2.tmp
REM pause
endlocal