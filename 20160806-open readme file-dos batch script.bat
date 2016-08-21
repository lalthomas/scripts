@echo OFF
setlocal
REM The following two line are Npp Hack for not changing the current path
%~d1
cd %~p1

REM Thanks http://stackoverflow.com/a/19706067/2182047
REM Original modified for need
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "longdatestamp=%YYYY%-%MM%-%DD%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

if exist "%~n1 readme.md" (	start explorer "%~n1 readme.md" ) else ( call :CREATEOPEN %1 )
exit /b 0
endlocal

:CREATEOPEN
Setlocal EnableDelayedExpansion
set "SUBJECT=%~n1 Readme"
set /p _Opt="redme file doesn't exist do you want tocreate (y/n) :"	
IF /I "%_Opt%" == "y" ( 	
	echo %% %SUBJECT% >>"%~n1 readme.md" ^
	&& echo %% %longdatestamp% >>"%~n1 readme.md" ^
	&& echo %% Lal Thomas >>"%~n1 readme.md" ^
	&& echo.>>"%~n1 readme.md" ^
	&& start explorer "%~n1 readme.md"
)
exit /b 0
