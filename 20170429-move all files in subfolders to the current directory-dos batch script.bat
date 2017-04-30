@echo OFF
setlocal
REM run only if folder is given as argument
IF [%~x1] == [] ( call :RUN %1 ) ELSE ( goto :END )
endlocal
goto :END

:RUN

set path=%PATH%;
%~d1
cd %1
echo.
set /p _Opt="Move all subfolder files of "%~1" to main folder (y/n) ? :"	
echo.
IF /I "%_Opt%" == "y" ( 
		for /f "delims=" %%f in ('dir /ad /b /s') do @move "%%f\*.*" "%CD%"		
)
echo.
set /p _Opt="Delete empty folders of "%~1" (y/n) ? :"	
echo.
IF /I "%_Opt%" == "y" ( 
	for /f "usebackq delims=" %%d in (`"dir /ad /b /s | sort /R"`) do rd "%%d"
)
exit /b 0
:END
