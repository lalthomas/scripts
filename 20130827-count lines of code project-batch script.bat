@echo OFF
REM ======================================
REM Author : Lal Thomas
REM Email  : lal.thomas.mail@gmail.com
REM ======================================
REM Record Time Stamp
REM Timestamp Generator
REM Parse the date (e.g., Fri 02/08/2008)
set cur_yyyy=%date:~10,4%
set cur_mm=%date:~4,2%
set cur_dd=%date:~7,2%
REM Parse the time (e.g., 11:17:13.49)
set cur_hh=%time:~0,2%
if %cur_hh% lss 10 (set cur_hh=0%time:~1,1%)
set cur_nn=%time:~3,2%
set cur_ss=%time:~6,2%
set cur_ms=%time:~9,2%
REM Set the timestamp format
set timestamp=%cur_yyyy%%cur_mm%%cur_dd%%cur_hh%%cur_nn%%cur_ss%%cur_ms%
set path=%PATH%;%CD%
set /p FOLDER=Enter the source code folder: 
cloc --report-file="lines-of-code-%timestamp%.txt" "%FOLDER%"
echo A report file has been created.....
pause

