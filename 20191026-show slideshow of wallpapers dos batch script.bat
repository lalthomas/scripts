@echo OFF
setlocal
REM Author : Lal Thomas
REM Date   : 2019-10-26

set ViewerPath="E:\PortableApps.com\PortableApps\IrfanViewPortable\IrfanViewPortable.exe"
set filelist="%USERPROFILE%\Desktop\slideshow.txt"
IF NOT EXIST %filelist% ( 
	call :PREPARE 
) ELSE ( 
	echo Showing Pictures from %filelist%
	echo ...
)
%ViewerPath% /closeslideshow /slideshow=%filelist% 
REM del %filelist%
endlocal
REM pause
exit /b 0

:PREPARE
REM set rootfolder="%USERPROFILE%\Pictures"
set rootfolder="F:\box"
echo Preparing List from %rootfolder%
echo ...
pushd %rootfolder%

REM running on pictures
REM echo ; List generated on %DATE% from  %rootfolder% >> %filelist%
REM dir /s /b /TA /OD *.jpg >>%filelist%

REM running on all folders
REM echo ; List generated on %DATE% from  %rootfolder% >> %filelist%
for /f "tokens=*" %%f in ('dir /b /TA /OD /A:D') do ( call :GENFILELIST %%~dpnxf )

exit /b 0
popd


:GENFILELIST
REM set folderpath="%1\pictures"
set folderpath="%1\documents"

IF EXIST %folderpath% ( 
	pushd %folderpath%
	dir /s /b /TA /OD *.jpg >>%filelist%
	popd
)

exit /b 0