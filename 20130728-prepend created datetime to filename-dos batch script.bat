@echo OFF
REM ****************************************************
setlocal
set path=%PATH%;%~dp1

for %%f in (%*) do ( 
 REM Thanks you http://stackoverflow.com/a/2541820
 CALL :RENAME %%f ) 
)

endlocal
REM pause
goto :END

:RENAME
	setlocal
	%~d1
	cd %~p1
	REM Script to get the attributes of file
	for /f "skip=5 tokens=1-8 delims=-/: " %%a in ('dir /tC %1') do (
		 set day=%%a
		 set mon=%%b
		 set yyyy=%%c
		 set hh=%%d
		 set min=%%e
		 set filename=%%h
		 goto label
	)

	:label
	REM %mon% %day% %yyyy% %hh% %min% %filename%
	REM Replaces all empty space
	set mon=%mon: =%
	set time=%yyyy%%mon%%day%
	REM echo %time%
	REM pause
	REM goto :EOF
	REM ****************************************************
	REN "%~n1%~x1" "%time%-%~n1%~x1"
	endlocal
EXIT /b 0

:END