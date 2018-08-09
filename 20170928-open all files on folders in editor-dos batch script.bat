@echo OFF
setlocal

%~d1
cd "%~1"

REM if argument is missing then current path is considered
IF [%1] == [] ( cd "%CD%" )

for /f "usebackq delims=|" %%f in (`dir /b %CD%`) do ( 
	set /a count=count+1		
	call :openfile "%%f"
)
exit /b 0
endlocal

:openfile
IF %count%==10 ( pause && set /a count=0 )
"%PROGRAMFILES%\Notepad++\notepad++.exe" "%~1"
exit /b 0