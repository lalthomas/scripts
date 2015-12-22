setlocal
@echo OFF
set path=%PATH%;%CD%
REM get the script folder path
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

REM Working (best size)
REM Batch willn't run on mp4 file
IF /I "%~x1" == ".mp4" ( goto END)

call "%scriptFolderPath%\tools\ffmpeg bundle\ffmpeg.exe" -i %1 -c:v libx264 -crf 23 "%~p1\%~n1.mp4"

::pause
:END
endlocal