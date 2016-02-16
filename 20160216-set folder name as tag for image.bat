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
pause
EXIT /b 0

:MAP
REM if not /i %%~xf == .jpg ( goto :EOF )
call :setImageMetaData %1
EXIT /b 0

:FOLDER
REM SET /p _Opt="Are you sure to process all files on the folder(y/n)" 
REM IF "%_Opt%" == "n" ( goto :EOF)
echo batch processing folder : %1 
REM for %%a in (%1\*.*) do ( CALL :MAP "%%a" )
call :setImageMetaData %1
EXIT /b 0

:setImageMetaData
set location=%1
IF [%~x1] == [] ( 
	set ParentDir=%~n1	
 ) ELSE (       
	set ParentDir=%~p1
	call :getParentFolderName
 )
set tags=%ParentDir%
set tags=%tags: =,%
call "%scriptFolderPath%\tools\exiftool\exiftool.exe" -overwrite_original_in_place -preserve -Keywords+="%tags%" %location%
EXIT /b 0


:getParentFolderName
REM thanks : http://stackoverflow.com/questions/2396003/get-parent-directory-name-for-a-particular-file-using-dos-batch-scripting
set ParentDir=%ParentDir: =:%
set ParentDir=%ParentDir:\= %
call :getparentdir %ParentDir%
set ParentDir=%ParentDir::= %
EXIT /b 0

:getparentdir
if "%~1" EQU "" goto END
set ParentDir=%~1
shift
goto :getparentdir
:END
endlocal