@echo OFF
setlocal
set path=%PATH%;C:\Program Files\IrfanView
i_view32.exe %1 /wall=2
i_view32.exe /killmesoftly
endlocal