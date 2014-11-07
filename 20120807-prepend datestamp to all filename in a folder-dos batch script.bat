set path="%PATH%;%CD%
for %%a in ("%CD%"\*.*) do ( call E:\Devel\Mis\RenFileDate.bat "%%a" )
REM Loop through all folders
for /d %%a in ("%CD%"\*) do  call E:\Devel\Mis\RenFileDate.bat "%%a" )

REM pause