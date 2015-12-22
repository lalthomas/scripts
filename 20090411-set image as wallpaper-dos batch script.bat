@echo OFF
setlocal
set path=%PATH%;D:\PortableApps.com\PortableApps\IrfanViewPortable\
IrfanViewPortable.exe %1 /wall=3
IrfanViewPortable.exe /killmesoftly
endlocal