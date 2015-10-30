@echo on
set dst_folder="F:\ted"

REM  Loop through the filelist

for /f "delims=" %%a in (filelist-10.txt) do (
xcopy /S /I %%a %dst_folder%
)
pause
