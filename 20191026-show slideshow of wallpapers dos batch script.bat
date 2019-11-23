@echo OFF
setlocal
REM Author : Lal Thomas
REM Date   : 2019-10-26
set ViewerPath="E:\PortableApps.com\PortableApps\IrfanViewPortable\IrfanViewPortable.exe"
set filelist="%USERPROFILE%\Desktop\slideshow.txt"
IF NOT EXIST %filelist% ( 
	call :PREPARE %1
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
set rootfolder="%~1"
IF NOT DEFINED %rootfolder% ( set /p rootfolder="Enter Path :" )
REM IF NOT EXIST "%rootfolder%" ( exit /b 1)
echo Preparing list from %rootfolder%
echo ...
pushd %rootfolder%
REM running on pictures from the  List generated from %rootfolder%]
for /f "tokens=*" %%f  in ('dir /b /TA /OD *.jpg') do ( echo %%~dpnxf >>%filelist% )
REM running on all folders from the generated list from %rootfolder%
for /f "tokens=*" %%g in ('dir /b /TA /OD /A:D') do ( call :GENFILELIST "%%~dpnxg" )
popd
exit /b 0


:GENFILELIST
set folderpath="%~1"
IF EXIST %folderpath% ( 
	pushd %folderpath%
	dir /s /b /TA /OD *.jpg >>%filelist%
	popd
)
exit /b 0