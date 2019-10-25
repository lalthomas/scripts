@echo OFF
REM DropIt
set dropitdir="E:\Portable App\dropit v8.2 portable"
pushd %dropitdir%
DropIt.exe -bin "F:\bin\*"
DropIt.exe -bin "%USERPROFILE%\*"
DropIt.exe -backup "%USERPROFILE%\*"
DropIt.exe -backup "C:\cygwin64\home\*"
popd

