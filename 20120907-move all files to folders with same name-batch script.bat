set path="%PATH%;%CD%
for %%a in ("%CD%"\*.*) do ( call E:\Devel\Mis\Organize.bat "%%a" )
REM pause