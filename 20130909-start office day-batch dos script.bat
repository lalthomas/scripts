@echo OFF
setlocal
REM ======================================
REM Author : Lal Thomas
REM Email  : lal.thomas.mail@gmail.com
REM ======================================

REM Welcome Messge
echo ===============================
echo Welcome to Start of Day Program
echo ===============================

REM Start of Day Record Time
start "SOD-Record-Time" "%CD%\tools\record-time.bat" start-of-day-arrival-time.txt
REM End of Start of Day Checklist

REM Start Common Apps
start "Firefox" "C:\Program Files\Mozilla Firefox\firefox.exe"
start "Thunderbird" "C:\Program Files\Mozilla Thunderbird\thunderbird.exe"
REM End of Start Common Apps

REM Start of Day Checklist
start "Ticket" "%CD%\tools\ticket.bat"
REM End of Start of Day Checklist

REM Apps for BB10 Development
start "QNX" "C:\bbndk\qde.exe" -data "D:\lalthomas\Dev\20130712-bb10-workspace"
REM End of BB10 Development

REM Start of Day Checklist
start "Start-of-Day-Checklist" /wait "%CD%\tools\checklist.bat" start-of-day-checklist.txt
REM End Start of Day Checklist

echo Contraz,You have done it!!!
echo Best of Luck !!!!
pause
endlocal