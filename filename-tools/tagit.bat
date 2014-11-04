@echo OFF
REM ****************************************************
setlocal
echo Tagit Options
echo .....................................................
echo 1. Append File Extension (default)
echo 2. Append Custom Tag 
echo 3. Exit
echo .....................................................
SET /p _Opt=Enter your choice : 

REM Set Default
IF NOT DEFINED _Opt SET _Opt="1"

IF /I "%_Opt%" == "1" ( goto FILEEXTENSION)
IF /I "%_Opt%" == "2" ( goto CUSTOMTAG)
IF /I "%_Opt%" == "3" ( goto END)
goto END


:FILEEXTENSION
REM ****************************************************
set str=%~x1
REM Remove the dot in %~x1 
set str=%str:.=%
REN %1 "%~n1 (%str%)%~x1"
REM pause
REM ****************************************************
endlocal
goto END

:CUSTOMTAG
REM ****************************************************
SET /p _CustomTag=Enter Tags (space separated) : 
IF NOT DEFINED _CustomTag goto END
SET tags=%_CustomTag%
SET tags=%tags: =") ("%
set tags="(%tags%)"
SET tags=%tags:"=%
REN %1 "%~n1 %tags%%~x1" 
goto END
REM ****************************************************

:END
endlocal
exit