@echo OFF
REM move film files and associated files to OK folder

REM accept folder path as argument
pushd %1

REM all files
for %%f in (*.*) do ( call :MOVEFILES "%%~dpnxf" )

popd

exit /b 0 

:MOVEFILES

REM obtain the year of creation of the file

REM get the creation date dir /tc
REM get the	modified date dir /tw
REM get the last access date dir /ta

for /f "tokens=3 delims=-" %%a in ('dir /tw %1') do set "yearpart=%%a"
set "myear=%yearpart:~0,4%"

if not exist %year% ( md %year% )

REM move file with its associated files 
move "%~dpn1.*" %year%

exit /b 0 

