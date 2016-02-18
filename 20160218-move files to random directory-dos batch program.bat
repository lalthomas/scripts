@echo ON
setlocal
set path=%PATH%;%~dp1
%~d1
cd %~dp1
set folderName=%random%
md %folderName%

for %%f in (%*) do ( 
 REM Thanks you http://stackoverflow.com/a/2541820
  move %%f %folderName%
)
endlocal