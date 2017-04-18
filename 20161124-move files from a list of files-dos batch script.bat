@echo OFF
setlocal
REM argument one - filelist
REM argument two - destinaton folder

REM TODO: add clipboard support for file list
REM TODO: add file selection support for file path output

%~d1
cd %~dp1

set filelist=%1
set destination=%2
IF [%1] == [] ( SET /p filelist="Enter filelist path: " )
set listmoved=""
call :movedfile %filelist%
IF [%2] == [] ( SET /p destination="Enter destinaton path : " )

REM loop through the filelist
REM	remove quotes

for /f "delims=" %%a in ( %filelist:"=% ) do (
	
	REM move files
	REM move "%%a" "%destination%"
	
	REM move all associated files	
	move "%%~dpna.*" "%destination%"
	
	IF %ERRORLEVEL% EQU 0 ( echo %destination%\%%~nxa>>%listmoved% )	
)

REM pause if needed
REM pause

REM exit
exit /b 0

:movedfile
set listmoved="%~dpn1-moved%~x1"
exit /b 0