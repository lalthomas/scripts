setlocal
REM Saves original path
set ORGIN=%PATH%

@echo OFF
setlocal
set path=%PATH%;C:\Program Files\Java\jdk1.5.0\bin
javac %1

REM Makes html file
set path=%ORGIN%
@echo ON
type E:\Devel\Mis\AppletTem_1.txt >AppletView.html
echo "%~n1" >>AppletView.html
type E:\Devel\Mis\AppletTem_2.txt >>AppletView.html

REM Runs the html file using appletviewer
@echo OFF
set path=%ORGIN%;C:\Program Files\Java\jdk1.5.0\bin
appletviewer AppletView.html

endlocal