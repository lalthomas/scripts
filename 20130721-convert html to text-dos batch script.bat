@echo OFF
setlocal

REM get the script folder path
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

set path=%PATH%;E:\Devel\Mis\Html2text

del "%temp%\%~n1.%~p1"
copy %1 "%temp%"

call "%scriptFolderPath%\tools\html2text\html2txt.exe" "%temp%\%~n1.%~p1" @html2txt.ini -AB-I-h--o:A 
copy "%temp%\%~n1.txt" "%~d1%~p1%~n1.txt"

endlocal
REM pause