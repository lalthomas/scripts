@echo OFF
REM script to print filenames in zip file
REM Lal Thomas
REM 2016-05-13
REM Thank you http://stackoverflow.com/a/21559391/2182047
REM Thank you http://stackoverflow.com/a/15568164/2182047

setlocal

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
call :PROCESS %1
endlocal
EXIT /b 0

:FOLDER
setlocal
SET /p _Opt="Are you sure to process all files on the folder(y/n)" 
IF "%_Opt%" == "n" ( goto :EOF)
echo batch processing folder : %1 
for %%a in (%1\*.*) do ( CALL :MAP "%%a" )
call :PROCESS %1
endlocal
EXIT /b 0

:PROCESS
	setlocal	
	%~d1
	cd %~p1
	set path=%path%;C:\Program Files\7-Zip
	set file=%1
	echo processing %file%...
	if exist %file%.txt (del %file%.txt)
	for /f "tokens=1,3 delims= " %%g in ('7z.exe l -slt %file%') do (  
	  echo.%%g | findstr /b /c:"Path" 1>nul
	  if NOT errorlevel 1 (		  
		  echo %%h >>%file%.txt
		  REM to extract infromation from filename
		  REM FOR %%i IN (%%h) DO (		
		  REM ECHO %%~xi >> list.txt	  
		  REM )	  	  
	  )  
	)
EXIT /b 0