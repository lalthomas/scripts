setlocal
@echo OFF
set path=%PATH%;%CD%
REM Working (best size)
REM Batch willn't run on mp4 file
IF /I "%~x1" == ".mp4" ( goto END)

REM config for big files
:: call E:\Devel\Mis\Video\ffmpeg.exe -i %1 -qmin 2 -qmax 5 -ar 22050 "%~n1.mp4"

REM config for small files
REM To improve the video quality, you can use a lower CRF value,
REM e.g. anything down to 18. To get a smaller file, use a higher CRF, 
REM but note that this will degrade quality.
REM To improve the audio quality, use a higher quality value. For FAAC, 100 is default.
call E:\Devel\Mis\Video\ffmpeg.exe -i %1 -c:v libx264 -crf 23 "%~n1.mp4"
::pause
:END
endlocal