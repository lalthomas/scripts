@echo OFF
setlocal
REM Invoke Irfanview for slideshow for the list passed as arguement
REM Author Lal Thomas
REM Date : 2017-07-07
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

set path=%PATH%;C:\PortableApps.com\PortableApps\IrfanViewPortable\
IrfanViewPortable.exe /slideshow=%1 /closeslideshow"

endlocal