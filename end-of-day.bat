@echo OFF
REM ======================================
REM Author : Lal Thomas
REM Email  : lal.thomas.mail@gmail.com
REM ======================================
REM Welcome Messge
echo ===============================
echo Welcome to End of Day Program
echo ===============================

REM Start of Day Checklist
start "Ticket" "%CD%\tools\ticket.bat"
REM End of Start of Day Checklist

REM Record the time
start "End of Day RecordTime" "%CD%\tools\record-time.bat"  end-of-day-exit-time.txt
REM End of Record Time Stamp

REM END of Day Checklist
start "Start of Day Checklist" /wait "%CD%\tools\checklist.bat" end-of-day-checklist.txt
REM End of End of Day Checklist

echo.
echo Contraz,You have done it!!!
echo Best of Luck !!!!
echo. 
echo =============
echo  Good Night
echo =============
pause
endlocal