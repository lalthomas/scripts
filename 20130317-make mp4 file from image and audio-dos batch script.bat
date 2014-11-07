setlocal
@echo OFF
set path=%PATH%;%CD%
REM Working (best size)
REM Batch willn't run on mp4 file
IF /I "%~x1" == ".mp4" ( goto END)
@echo ON

REM SET /p musicfilepath=Enter the path of mp3 file : 
REM SET /p photofilepath=Enter the path of photo file : 
REM @echo ON

SET musicfilepath="Y:\Inbox\Music\hindi\Bhul Na Jana.mp3"
SET photofilepath="E:\LT Space\Data\SkyDrive\Saved pictures\[+]LockScreen_16 43.jpg"

REM ffmpeg -i %musicfilepath% -ar 44100 -f image2 -i %photofilepath% -r 15 -s 640x480 -loop 1 -shortest -c:v libx264 -crf 18 -tune stillimage -preset medium sample.mp4

ffmpeg -loop 1 -r ntsc -i %photofilepath% -i %musicfilepath% -c:a copy -c:v libx264 -preset fast -threads 0 -shortest output.mp4

pause