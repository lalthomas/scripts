@echo OFF

set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

REM get admin previllage for the batch
REM thanks : https://stackoverflow.com/a/10052222/2182047

REM Check for permissions
REM	--------------------- 

IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" ( 
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system" 
) ELSE ( 
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" 
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( 
	goto gotAdmin 
)


:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

REM --------------------------------------




REM get the current time and add 10 minutes
call :addTime %time% 5
set tStartTime=%nTime%

REM add 1 minute to task start time
call :addTime %tStartTime% 3
set tEndTime=%nTime%

echo "[%tStartTime%] - [%tEndTime%]"

REM create windows scheduler task with start time and end time
call :createWinSchduleTask "Pomo Lock" "C:\Windows\System32\rundll32.exe user32.dll,LockWorkStation" "%tStartTime%" "%tEndTime%"


goto :END

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
set name=%~1
set task=%~2
set startTime=%~3
set endTime=%~4

REM call task scheduler
SchTasks ^
	/Create ^
		/SC once ^
		/RL HIGHEST ^
		/TN "%name%" ^
		/TR "%task%" ^
		/ST "%startTime%" ^
		/ET "%endTime%" ^
		/RI 0 ^
		/K ^
		/Z

REM copy the file
robocopy "C:\windows\system32\Tasks" "D:\temp" "%name%"
pushd "D:\temp"
REM change the code page to utf-8
chcp 65001>NUL
type "%name%" > "%name%.xml"
popd

REM edit the file
REM edit the line to make it windows 8.1 compatible
call "%scriptFolderPath%\tools\fart\fart.exe" "d:\temp\%name%.xml" "<DisallowStartIfOnBatteries>true</DisallowStartIfOnBatteries>" "<DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>" >nul 2>nul

REM delete the task 
SCHTASKS ^
	/Delete ^
        /TN "%name%" ^
		/F
		
REM import the file
SchTasks ^
	/CREATE ^
		/XML "D:\temp\%name%.xml" ^
		/TN "%name%" ^
		/F
	
exit /b 0

:END