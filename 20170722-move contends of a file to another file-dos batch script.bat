@echo OFF
setlocal
REM 20170722-move contends of a file to another file-dos batch script.bat 
REM Author : Lal Thomas
REM 2017-07-22	
REM first argument is the source file
REM second argument is the destination file

REM add new line to destination file
echo.>>%2

REM add contends of source file to destination file
type %1 >>%2

REM empty source file
echo.>%1

REM pause
endlocal