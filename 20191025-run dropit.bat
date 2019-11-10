setlocal
@echo OFF
REM DropIt
set dropitdir="E:\Portable App\dropit v8.2 portable"
set "cdate=%date%"
set "cday=%date:~0,2%"
set "cmonth=%date:~3,2%"
set "cyear=%date:~6,4%"
set tdate=%cyear%%cmonth%%cday%

REM comment after testing
call :RUNDROPIT
pause
endlocal
exit /b 0

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
endlocal
exit /b 0

:RUNDROPIT

REM run on dbin
pushd "D:\bin"
for /f "tokens=*" %%E in ('dir /a:D /b') do (
	cd %%E
	
	REM if %%E EQU nokia_1 ( call "%~dp0\profiles\nokia_1.bat" "%%~dpnxE" )
	if %%E EQU mi_pad ( call "%~dp0\profiles\mi_pad.bat" "%%~dpnxE" )
	if %%E EQU vivo_y21l ( call "%~dp0\profiles\vivo_y21l.bat" "%%~dpnxE" )
	
	cd ..
)
popd

REM TODO run on fbin
REM 

REM run on acer aspire 3
REM call "%~dp0\profiles\acer_aspire3.bat"

REM log the run
pushd %APPDATA%\DropIt
if not exist log ( md log )
echo >log\%cyear%%cmonth%%cday%.log
popd

exit /b 0
