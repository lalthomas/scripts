@echo OFF
setlocal
set path=%PATH%;C:\Program Files\Java\jdk1.5.0\bin
java -jar "%1"
echo Press any key to continue
pause
endlocal