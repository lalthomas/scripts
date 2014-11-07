@echo OFF
set path="%PATH%;%CD%
for %%a in ("%CD%"\*.*) do ( call E:\Devel\Mis\Folderize.bat "%%a" )
REM Loop through all folders
for /d %%a in ("%CD%"\*) do ( call E:\Devel\Mis\Folderize.bat "%%a" )
REM pause