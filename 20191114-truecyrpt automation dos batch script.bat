@echo OFF
setlocal
%~d1
REM main argument is root path of year folders
pushd %1
set truecryptpath="C:\Program Files (x86)\TrueCrypt\TrueCrypt.exe"
set /p pass="Enter Password: "

for /f "tokens=*" %%f in ('dir /b /TA /OD /A:D') do ( 
	pushd %%f
	call :nodrive
	if ERRORLEVEL 1 ( call :mountvol %%f )
	popd
 )
call :nodrive
popd
endlocal
exit /b 0


:nodrive
REM dismount I drive
call %truecryptpath% /s /q /d I
if exist I: ( 
	echo Drive didn't dismount. Try manual dismount...
	call %truecryptpath% /d I	
	exit /b 0
)
exit /b 1

:mountvol
if exist %1.tc ( 
	REM open truecrypt volume
	call %truecryptpath% /q /v %~dpn1.tc /p %pass% /l I
	REM execute the action
	call :action %1
	REM close truecrypt volume	
	call %truecryptpath% /q /d I
)
exit /b 0

:action
echo.
echo Taking action on %1 :
pause
exit /b 0



