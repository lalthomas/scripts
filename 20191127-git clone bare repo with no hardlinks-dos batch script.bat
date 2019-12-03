@echo OFF
REM Author : Lal Thomas
REM Date : 2019-11-29
setlocal

%~d0
cd "%~p0"

REM get the script folder path
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

REM Thanks http://stackoverflow.com/a/19706067/2182047
REM Original modified for need
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "longdatestamp=%YYYY%-%MM%-%DD%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

set REPODIR="Y:\%YYYY%\Repos"
set RPath=%1

REM If path is not provided via argument 
IF [%RPath%] == [] call :SETREPOFROMCLIP

REM Still path is not provided via clipboard
IF [%RPath%] == [] call :SETREPOFROMINPUT

REM Else exit
IF [%RPath%] == [] (
	echo "Error: Path not provided."
	echo "Existing"
	exit /b 0
)

call :GCLONE %REPODIR% %RPath%
REM pause
endlocal
exit /b 0

:SETREPOFROMCLIP
REM Receive the repo to clone from Windows Clipboard
for /f "tokens=* usebackq" %%f in (`"%scriptFolderPath%\tools\paste\paste.exe"`) do (
	set CLIP=%%f
)

REM If path exists then continue
IF EXIST "%CLIP%" ( 
	set RPath="%CLIP%"
	exit /b 0
)

REM IF not exists confirm
set /p _Opt="Do you want to clone "%CLIP%" to "%REPODIR% (y/n) :"
IF /I "%_Opt%" == "y" ( set RPath="%CLIP%" )

exit /b 0

:SETREPOFROMINPUT
REM Receive the input from user input
SET /p INPUT=Enter repo path to clone : 
IF EXIST "%INPUT%" ( set RPath="%INPUT%" )
echo %RPath%
exit /b 0

:GCLONE
set path=%PATH%;%~dp1;
pushd "%~1"
echo.
git clone --bare --no-hardlinks "file://%~2"
cd %~dpnx1\%~n2.git
echo.
git fsck
REM remove the remote - origin 
git remote remove origin
echo.
git gc
popd
REM explorer "%~dpnx1\%~n2.git"
call "C:\Program Files (x86)\GitExtensions\gitex.cmd" browse "%~dpnx1\%~n2.git"
exit /b 0
