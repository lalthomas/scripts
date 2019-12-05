@echo OFF
setlocal
REM Script to generate file listing
REM Author Lal Thomas

%~d1
pushd %1

for /f "tokens=*" %%f in ('dir /b /TA /OD /A:D') do ( 
	pushd %%f
	call :genallfilelist %%f
	call :genmoviefilelist %%f
	popd
 )
 
popd

endlocal
exit /b 0
 
:genallfilelist
REM remove already existing file
dir /b >>".\..\%1 files index.txt"
exit /b 0
 
:genmoviefilelist
for %%f in (*.mov,*.rmvb,*.3gp,*.wmv,*.m2ts,*.mpeg,*.webm,*.nsv,*.asf,*.flv,*.avi,*.divx,*.m4v,*.mkv,*.mp4,*.mpg,*.vob) do ( 
	echo %%~dpnxf >>".\..\%1 films files index.txt"
)
exit /b 0