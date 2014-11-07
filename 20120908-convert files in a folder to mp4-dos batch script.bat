set path="%PATH%;%CD%
for %%a in ("%CD%"\*.*) do ( call E:\Devel\Mis\Video\file2mp4.bat "%%a" )
REM pause