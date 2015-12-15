
set file=""
REM for batch file use %%f else use %f
for /f "tokens=*" %%f in ('dir . /ad/b') do copy %file% "%%f"
