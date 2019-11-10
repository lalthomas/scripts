@echo ON
REM Author : Lal Thomas

echo Processing Mi Pad Files
set dropitdir="E:\Portable App\dropit v8.2 portable"
pushd %1

REM Process each date folders
for /f "tokens=*" %%f in ('dir /a:D /b') do (
				
		pushd %%f
		for /f "tokens=*" %%D in ('dir /b /s /a:D') do (
			
			REM this I am doing because I couldn't find string comparison operators
			set folder=%%D	
			REM 11 is the length of "DCIM\Camera" string
			set camdir=%folder:~-11%
			if /i "%camdir%"=="DCIM\Camera" ( call :dcim "%%~dpnxD" )
			
		)
		popd
	)
popd
exit /b 0

:dcim
pushd %dropitdir%
DropIt.exe -file_year_date_taken "%1\*.jpg"
popd
exit /b 0
