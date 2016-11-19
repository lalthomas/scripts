@echo OFF
REM ======================================
REM Author : Lal Thomas
REM Email  : lal.thomas.mail@gmail.com
REM ======================================

setlocal
set path=%PATH%;%CD%
REM get the script folder path
setlocal ENABLEDELAYEDEXPANSION
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

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
REM %cur_hh%%cur_nn%%cur_ss%%cur_ms%
set timestamp=%cur_yyyy%%cur_mm%%cur_dd%

REM Get the source folder
set /p FOLDER=Enter the source code folder: 
pushd %FOLDER%
set reportfile="%timestamp%-lines-of-code.txt"
"%scriptFolderPath%\tools\cloc\cloc.exe" --report-file=%reportfile% "%FOLDER%"
IF %ERRORLEVEL% EQU 0 (
	REM sucess
	echo Report file %reportfile% has been generated
	start "" "%FOLDER%\%reportfile%"
) ELSE (
	REM Fail
	echo Report file couldn't be generated
	pause
)
popd
endlocal