@echo OFF
setlocal

%~d1
pushd %1
set /p pass="Enter Password: "
for /f "tokens=*" %%f in ('dir /b /TA /OD /A:D') do ( 
	pushd %%f	
	call :mountvol %%f
	popd
 )
 
popd

endlocal
exit /b 0


:mountvol
pushd %~dp1
for %%f in (*.tc) do (
	set truecryptpath="C:\Program Files (x86)\TrueCrypt\TrueCrypt.exe"
	%truecryptpath% /q /v %%~dpnxf /p %pass% /e
)

popd
exit /b 0


