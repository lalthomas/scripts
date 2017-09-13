@echo OFF
REM Batch file to add to inbox.md file on do folder
REM Lal Thomas
REM 2017-09-07

REM CSV file is the first argument
REM filname is passes as first argument
set file=%1

for /f %%a in (%file%) do (
  echo %%a
  exit /b
)