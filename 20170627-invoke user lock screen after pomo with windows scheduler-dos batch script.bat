@echo OFF




REM get the current time and add 10 minutes
call :addTime %time% 2
set tStartTime=%nTime%
REM add 1 minute to task start time
call :addTime %tStartTime% 30
set tEndTime=%nTime%
echo "[%tStartTime%] - [%tEndTime%]"

REM create windows scheduler task with start time and end time
call :createWinSchduleTask "Lock1" "%tStartTime%" "%tEndTime%"
pause

REM edit the line to make it windows 8.1 compatible

call 

exit

REM 
:addTime

REM parameters
set pTime=%1
set intervalMinutes=%2

REM parse the time for hour minute and seconds
for /F "tokens=1-3 delims=:." %%a in ("%pTime%") do (
   set timeHour=%%a
   set timeMinute=%%b
   set timeSeconds=%%c
)
rem Convert HH:MM to minutes
set /A newTime=timeHour*60 + timeMinute + %intervalMinutes%
rem Convert new time back to HH:MM
set /A timeHour=newTime/60, timeMinute=newTime%%60
rem Adjust new hour and minute
if %timeHour% gtr 23 set timeHour=0
if %timeHour% lss 10 set timeHour=0%timeHour%
if %timeMinute% lss 10 set timeMinute=0%timeMinute%
set nTime=%timeHour%:%timeMinute%:%timeSeconds%
exit /b 0

:createWinSchduleTask

REM set the parameters
set name=%1
set startTime=%2
set endTime=%3

REM call task scheduler
SchTasks ^
	/Create /SC once ^
		/RL HIGHEST ^
		/TN "%name%" ^
		/TR "C:\Windows\System32\rundll32.exe user32.dll,LockWorkStation" ^
		/ST %startTime% ^
		/ET %endTime% ^
		/RI 0 ^
		/K ^
		/Z ^		
exit /b 0


:editLine

taskname=%1

REM c:\windows\system32\tasks
REM replace "<DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>" "<DisallowStartIfOnBatteries>true</DisallowStartIfOnBatteries>"

exit /b 0