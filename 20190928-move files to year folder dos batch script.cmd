@echo OFF
REM move film files and associated files to OK folder

REM accept folder path as argument
pushd %1

REM all files
for %%f in (*.*) do ( call :MOVEFILES "%%~dpnxf" )

popd

exit /b 0 

:MOVEFILES

REM get the	modified date ( dir /tw )
for /f "tokens=3 delims=-" %%a in ('dir /tw %1') do set "yearpart=%%a"
set "myear=%yearpart:~0,4%"

REM get the creation date ( dir /tc )
for /f "tokens=3 delims=-" %%a in ('dir /tw %1') do set "yearpart=%%a"
set "cyear=%yearpart:~0,4%"

REM obtain the year of the file
if not exist %year% ( md %year% )

REM move file with its associated files 
move "%~dpn1.*" %year%

exit /b 0 

