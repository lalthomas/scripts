@echo ON
set runfile="FILEPATH"
for /f "tokens=*" %%f in ('dir /a:D /s /b') do  %runfile% "%%f"
pause