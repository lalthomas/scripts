@echo OFF
setlocal
REM Download the video file from popular websites. This script have no argument; the video URL is perceived from the windows clipboard
REM Author Lal Thomas
REM Date : 2017-05-14
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%
set filename=%1

REM change the path to argument folder
%~d1
pushd %~dp1
REM add head text for markdown image
echo ^!^[%~n1]^(data:image/jpeg;base64,>>"%~n1.tmp"
REM add base64 encoding for the file
"%scriptFolderPath%\tools\base64\base64.exe" -e "%~nx1" -s >>"%~n1.tmp"
REM add tail text
echo ^) ^<br^/^> >>"%~n1.tmp"
REM remove newlines
set path="%scriptFolderPath%\tools\fart";%PATH%
fart -qC --remove "%~dpn1.tmp" "\r" >new.txt
fart -qC --remove "%~dpn1.tmp" "\n" >new.txt
REM end of remove newlines

REM copy to clipboard
clip<"%~n1.tmp"
REM delete temporary file
del "%~n1.tmp"
REM change to original path
popd

endlocal
REM pause