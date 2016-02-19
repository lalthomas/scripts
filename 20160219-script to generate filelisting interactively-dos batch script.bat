@echo OFF
REM ======================================
REM Author : Lal Thomas
REM Email  : lal.thomas.mail@gmail.com
REM ======================================
set /p FOLDER=Enter folder path : 
call :generateListing %FOLDER%
pause
exit \b 0

:generateListing
%~d1
cd %~dpn1
dir /a:-d-h /b /s /oN >"filelist.txt"
exit \b 0