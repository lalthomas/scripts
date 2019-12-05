@echo OFF
setlocal
set path=%PATH%;%CD%;
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%
for %%a in ("%CD%"\*.*) do ( call %scriptFolderPath%\20130819-convert file to markdown using pandoc-dos batch script.bat "%%a")
endlocal