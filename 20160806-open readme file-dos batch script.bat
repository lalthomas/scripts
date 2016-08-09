@echo OFF
setlocal
REM The following two line are Npp Hack for not changing the current path
%~d1
cd %~p1
if exist "%~n1 readme.md" (	start explorer "%~n1 readme.md" ) else ( call :CREATEOPEN %1 )
exit /b 0
endlocal

:CREATEOPEN
Setlocal EnableDelayedExpansion
set "SUBJECT=%~n1 Readme"
set /p _Opt="redme file doesn't exist do you want tocreate (y/n) :"	
IF /I "%_Opt%" == "y" ( 	
	echo %% %SUBJECT% >>"%~n1 readme.md" ^
	&& echo %% %DATE% >>"%~n1 readme.md" ^
	&& echo %% Lal Thomas >>"%~n1 readme.md" ^
	&& echo.>>"%~n1 readme.md" ^
	&& start explorer "%~n1 readme.md"
)
exit /b 0
