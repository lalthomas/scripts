@echo OFF
REM Author Lal Thomas
REM Date : 2016-02-16
REM get the script folder path
setlocal ENABLEDELAYEDEXPANSION
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%
set path=%PATH%;%~dp1
%~d1
cd %~dp1
for %%f in (%*) do ( 
 REM Thanks you http://stackoverflow.com/a/2541820
 IF [%%~xf] == [] ( 
  IF EXIST %%f ( CALL :FOLDER %%f )
 ) ELSE ( 
  IF EXIST %%f ( CALL :MAP %%f )
 )
)
echo Done !!!
pause
EXIT /b 0

:MAP
setlocal
REM if not /i %%~xf == .jpg ( goto :EOF )
call :fixImageMetaData %1
endlocal
EXIT /b 0

:FOLDER
setlocal
REM SET /p _Opt="Are you sure to process all files on the folder(y/n)" 
REM IF "%_Opt%" == "n" ( goto :EOF)
echo batch processing folder : %1 ...
for %%a in (%1\*.*) do ( CALL :MAP "%%a" )
endlocal
EXIT /b 0

:fixImageMetaData
setlocal
set location=%1
set tempFileName=%~n1.txt

REM reads all metadata and write to file
REM call "%scriptFolderPath%\tools\exiftool\exiftool.exe" -a -u -g1 %location%>%tempFileName%

REM get the keywords and write to file
call "%scriptFolderPath%\tools\exiftool\exiftool.exe" -quiet -iptc:Keywords %location%>%tempFileName%
call "%scriptFolderPath%\tools\fart\fart.exe" -q %tempFileName% "Keywords                        : " "#"
set /p data=<%tempFileName%
REM echo data is %data%
set data=%data:.=%
set data=%data:,=; %
set data=%data:/=; %
set data=%data:  = %
set data=%data:#=%

REM remove duplicate values
REM ----------------------------
for %%a in ( %data% ) do (	
	set elem[%%a]=X
)
set "noDupData=#"
for /F "tokens=2 delims=[]" %%a in ( 'set elem[' ) do (
 call :concat %%a 
)
set data=%noDupData%
REM echo unique data : %data%
REM replace place holder value"
set data=%data:#;=%
REM end of removal of duplicate values

REM convert to data to lowercase
REM ----------------------------
set "_UCASE=ABCDEFGHIJKLMNOPQRSTUVWXYZ"
set "_LCASE=abcdefghijklmnopqrstuvwxyz"
for /l %%a in (0,1,25) do (
 call set "_FROM=%%_UCASE:~%%a,1%%
 call set "_TO=%%_LCASE:~%%a, 1%%
 call set "data=%%data:!_FROM!=!_TO!%%
)
REM end of case conversion
echo processing : %location%
call "%scriptFolderPath%\tools\exiftool\exiftool.exe" -quiet -overwrite_original_in_place -preserve -sep ";" -Keywords="%data%" %location%
del %tempFileName%
endlocal
EXIT /b 0


:concat
set noDupData=%noDupData%; %1
EXIT /b 0