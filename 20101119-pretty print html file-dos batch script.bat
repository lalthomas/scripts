@echo OFF
setlocal
set path=%PATH%;E:\Devel\Mis\Tidy
copy %1 E:\Temp\Arch.html
tidy -config E:\Devel\Mis\Tidy\TidyConfig.ini "E:\Temp\Arch.html"
copy E:\Temp\Arch.html "%1" 
if "%~n1"== "Blog" (goto end)
pause
:end
endlocal