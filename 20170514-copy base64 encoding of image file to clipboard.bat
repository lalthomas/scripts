@echo OFF
setlocal
REM Encode the image with bas64; if no argument found the content is taken from clipboard
REM Author Lal Thomas
REM Date : 2017-05-14
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

REM if no argument found then content is taken from clipboard
IF [%1] == [] ( GOTO PASTEBIN )
set filename=%1
REM echo %filename%
call :ENCODER %1
exit

:PASTEBIN
set temppath=d:\temp
set filepath="%temppath%\%random%.jpg"
pushd %temppath%
set path=%PATH%;C:\PortableApps.com\PortableApps\IrfanViewPortable\
IrfanViewPortable.exe %1 /clippaste /convert=%filepath%
IrfanViewPortable.exe /killmesoftly
call :ENCODER %filepath%
del %filepath%
popd
exit /b 0

:ENCODER

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
fart -qC --remove "%~dpn1.tmp" "\r" 2> nul
fart -qC --remove "%~dpn1.tmp" "\n" 2> nul
REM end of remove newlines

REM copy to clipboard
clip<"%~n1.tmp"

REM delete temporary file
del "%~n1.tmp"

REM change to original path
popd

REM exit
exit /b 0

endlocal
REM pause