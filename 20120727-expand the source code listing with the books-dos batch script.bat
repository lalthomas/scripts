setlocal
@echo OFF
set path=%path%;E:\Devel\Mis\csplit
csplit -s -z %1 /listing.[0-9]/ {*}
endlocal