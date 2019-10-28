@echo OFF
REM DropIt
set dropitdir="E:\Portable App\dropit v8.2 portable"
set "cdate=%date%"
set "cday=%date:~0,2%"
set "cmonth=%date:~3,2%"
set "cyear=%date:~6,4%"
set tdate=%cyear%%cmonth%%cday%


REM find last run date
pushd %APPDATA%\DropIt

REM initial run
if not exist log ( call :RUNDROPIT )

set lastrundate=%tdate%
for /f "tokens=1 delims=." %%a in ('dir /o-N /b .\log') do set "lastrundate=%%a"

popd

REM call the dropit only if it has been 7 days
set /a change=%tdate%-%lastrundate%
if /i %change% GTR 7 ( call :RUNDROPIT ) 

exit /b 0

:RUNDROPIT
pushd %dropitdir%
DropIt.exe -bin "F:\bin\*"
DropIt.exe -bin "%USERPROFILE%\*"
DropIt.exe -backup "%USERPROFILE%\*"
DropIt.exe -backup "C:\cygwin64\home\*"
popd

REM log the run
pushd %APPDATA%\DropIt
if not exist log ( md log )
echo >log\%cyear%%cmonth%%cday%.log
popd


exit /b 0



