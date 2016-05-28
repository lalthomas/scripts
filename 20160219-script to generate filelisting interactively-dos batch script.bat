@echo OFF
REM ======================================
REM Author : Lal Thomas
REM Email  : lal.thomas.mail@gmail.com
REM ======================================
set /p FOLDER=Enter folder path : 
call :generateListing %FOLDER%
REM open file
%FOLDER%\filelist.txt
pause
exit \b 0

:generateListing
%~d1
cd %~dpn1
dir /a:-d-h /b /s /oN >"filelist.txt"
echo filelist generated on %1