REM Author Lal Thomas
REM Date 2019-11-25
@echo OFF

set filelist="%~1"
for /F "usebackq" %%f in (%filelist%) DO (
	del %%f
)