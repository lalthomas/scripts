echo Processing Nokia 1 Files
set dropitdir="E:\Portable App\dropit v8.2 portable"

echo %1
pushd %1

for /f "tokens=*" %%f in ('dir /a:D /b') do (
		
		REM TODO run the batch file corresponding to folder
			
		pushd %dropitdir%
		DropIt.exe -year_date_taken "%%~dpnxf\*"
		popd
		
	)

popd
