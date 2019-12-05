@echo OFF
setlocal
REM move film files and associated files to OK folder

%~d1
pushd %1

REM all video files
for %%f in (*.mov,*.rmvb,*.3gp,*.wmv,*.m2ts,*.mpeg,*.webm,*.nsv,*.asf,*.flv,*.avi,*.divx,*.m4v,*.mkv,*.mp4,*.mpg,*.vob,*.m4v) do ( call :MOVEFILES "%%~dpnxf" )
popd

endlocal

exit /b 0 

:MOVEFILES

REM obtain the year of creation of the video file

REM get the creation date dir /tc
REM get the	modified date dir /tw
REM get the last access date dir /ta

for /f "tokens=3 delims=-" %%a in ('dir /tc %1') do set "yearpart=%%a"
set "year=%yearpart:~0,4%"

if not exist %year% ( md %year% )

move "%~dpn1.*" %year%
move "%~dpn1-fanart.*" %year%
move "%~dpn1-poster.*" %year%

exit /b 0 

