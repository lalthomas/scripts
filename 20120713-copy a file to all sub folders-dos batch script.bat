set file=%1
REM for batch file use %%f else use %f
for /f "tokens=*" %%f in ('dir "%~p1" /ad/b') do copy %file% "%~p1\%%f"
pause