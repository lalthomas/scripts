@echo OFF
setlocal

REM  Loop through the filelist
%~d1
cd %~dp1

SET /p _Opt="Are you sure to delete the file and associated files (y/n)" 
IF "%_Opt%" == "n" ( goto :EOF)

for %%f in (%*) do ( del "%%~dpnf.*")

endlocal
pause