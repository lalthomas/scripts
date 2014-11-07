@echo OFF
setlocal
set path=%PATH%;%CD%;D:\Program Files\Pandoc\bin
for %%a in ("%CD%"\*.*) do ( call E:\Devel\Mis\Markdownify.bat "%%a")
endlocal