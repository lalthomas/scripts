@echo OFF
setlocal
REM 20170722-move contends of a file to another file-dos batch script.bat 
REM Author : Lal Thomas
REM 2017-07-22	
REM first argument is the source file
REM second argument is the destination file
echo.>>%2
type %1 >>%2

REM create unicode file
chcp 65001
echo.>%1
endlocal