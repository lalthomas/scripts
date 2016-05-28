@echo OFF
set path=%PATH%;%~dp1
%~d1
cd %~dp1
set dateString="%DATE%"
FOR /F "tokens=2,3,4 delims=/ " %%G IN (%dateString%) DO  IF NOT EXIST "%%G-%%H-%%I"\NUL MD "%%I%%H%%G"
REM pause
