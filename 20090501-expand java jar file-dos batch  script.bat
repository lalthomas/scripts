REM expand java jar file
REM Lal Thomas
REM 2009-05-01
@echo OFF
setlocal
set path=%PATH%;C:\Program Files\Java\jdk1.5.0\bin
jar -xvf %1
echo Press any key to continue
pause
endlocal