@echo OFF
setlocal
REM Download the video file from popular websites. This script have no argument; the video URL is perceived from the windows clipboard
REM Author Lal Thomas
REM Date : 2017-05-07
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

pushd "D:\Downloads"
for /f "tokens=* usebackq" %%f in (`"%scriptFolderPath%\tools\paste\paste.exe"`) do (
set url=%%f
)
echo %url%
REM start cmd /k %PYTHON2% 
%scriptFolderPath%\tools\youtube-dl\youtube-dl.exe %url%
popd

