setlocal
@echo OFF
REM Author : Lal Thomas

echo Processing Mi Pad Files
set dropitdir="E:\Portable App\dropit v8.2 portable"
pushd %1

REM Process each date folders
for /f "tokens=*" %%f in ('dir /a:D /b') do (
		pushd %%f
		for /f "tokens=*" %%D in ('dir /b /s /a:D') do (
			call :compare "%%D"
		)
		popd
	)
popd
endlocal
exit /b 0

:compare
setlocal
set pt=%*
REM converting path string to string
set dp="%pt%"
 REM removing double quotes with single quotes
 set "dp=%dp:""="%


REM this I am doing because I couldn't find string comparison operators
REM 11 is the length of "DCIM\Camera" string
set camdir=%dp:~-11%
if "%camdir%" == "DCIM\Camera" ( call :dcim %pt% )

endlocal
exit /b 0


:dcim
setlocal
pushd %dropitdir%
DropIt.exe -file_year_date_taken "%1\*.jpg"
popd
endlocal
exit /b 0
