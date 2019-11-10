@echo ON
setlocal
REM Author : Lal Thomas

echo Processing Vivo Y21L Files
set dropitdir="E:\Portable App\dropit v8.2 portable"
pushd %1

REM Process each date folders
for /f "tokens=*" %%f in ('dir /a:D /b') do (

		pushd %%f
		for /f "tokens=*" %%D in ('dir /b /s /a:D') do (
			
			set folderN="%%~nD"
			set folder=%%D
			
			REM this I am doing because I couldn't find string comparison operators
			REM 11 is the length of "DCIM\Camera" string
			REM set camdir=%folder:~-11%
			REM if /i "DCIM\Camera" == "%camdir%"  ( call :dcim "%%~dpnxD" )
			REM if /i %folderN% == "Download" ( call :download "%%~dpnxD" )
			REM if /i %folderN% == "Pictures" ( call :pictures "%%~dpnxD" )
			
			
		)
		popd
	)
popd
endlocal
exit /b 0

:dcim
pushd %dropitdir%
DropIt.exe -file_year_date_taken "%1\*.jpg"
popd
exit /b 0

:download
pushd %dropitdir%
DropIt.exe -file_year_date_modified "%1\*"
popd
exit /b 0

:pictures
pushd %dropitdir%
DropIt.exe -device_vivo_y21l "%1\*"
popd
exit /b 0


exit /b 0
