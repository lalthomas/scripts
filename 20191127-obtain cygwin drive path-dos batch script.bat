REM Author : Lal Thomas
REM Date : 2019-11-27
@echo OFF
%~d0
cd %~dp0
REM set fpath="D:\project\folder-bash script.sh"
set fpath=%*
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%
set fullfilepath="%CD%\tmp.bat"
echo C:\cygwin64\bin\mintty.exe -i /Cygwin-Terminal.ico  C:\cygwin64\bin\bash.exe -l -c "cygpath \"$FP$\" | clip && exit; exec bash; source ~/.bash_profile;">tmp.bat
echo exit >>tmp.bat
call "%scriptFolderPath%\tools\fart\fart.exe" %fullfilepath% "$FP$" %fpath% >nul 2>nul
start /wait tmp.bat
for /f "tokens=* usebackq" %%f in (`"%scriptFolderPath%\tools\paste\paste.exe"`) do (
	set cygwinpath=%%f
)
echo %cygwinpath%
del tmp.bat
REM pause
