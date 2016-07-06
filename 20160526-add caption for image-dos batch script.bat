@echo ON
setlocal
REM batch script to add caption to image using exiftool
REM Author Lal Thomas
REM Date : 2016-02-16

REM get the script folder path
setlocal ENABLEDELAYEDEXPANSION
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%
%~d1
cd %~dp1
echo Add Caption
echo ===========
echo.
echo For filename as caption press enter
SET /p _caption="Enter caption for the image : " 
for %%f in (%*) do ( 
 REM Thanks you http://stackoverflow.com/a/2541820
 IF [%%~xf] == [] ( 
  IF EXIST %%f ( CALL :FOLDER %%f )
 ) ELSE ( 
  IF EXIST %%f ( CALL :MAP %%f )
 )
)
endlocal
pause
EXIT /b 0

:MAP
setlocal
REM if not /i %%~xf == .jpg ( goto :EOF )
call :setImageMetaData %1
endlocal
EXIT /b 0

:FOLDER
setlocal
REM SET /p _Opt="Are you sure to process all files on the folder(y/n)" 
REM IF "%_Opt%" == "n" ( goto :EOF)
echo batch processing folder : %1 
REM for %%a in (%1\*.*) do ( CALL :MAP "%%a" )
call :setImageMetaData %1
endlocal
EXIT /b 0

:setImageMetaData
setlocal
%~d1
cd %~dp1
set location=%1
if [%_caption%]==[] set _caption=%~n1
if /i %~x1 == .jpg (
	call "%scriptFolderPath%\tools\exiftool\exiftool.exe" -overwrite_original_in_place -preserve -IPTC:Caption-Abstract="%_caption%" %location%
 )

endlocal
:END
EXIT /b 0
