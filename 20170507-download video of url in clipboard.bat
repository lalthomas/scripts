@echo OFF
setlocal
REM Author Lal Thomas
REM Date : 2017-05-07
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

pushd "D:\Downloads"
for /f "tokens=* usebackq" %%f in (`"%scriptFolderPath%\tools\paste\paste.exe"`) do (
set url=%%f
)
echo %url%
start cmd /k %PYTHON2% C:\Python27\Scripts\youtube-dl.exe  %url%
popd

