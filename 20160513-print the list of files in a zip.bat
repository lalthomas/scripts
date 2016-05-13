@echo off
REM Lal Thomas
REM 2016-05-13
REM Thank you http://stackoverflow.com/a/21559391/2182047
REM Thank you http://stackoverflow.com/a/15568164/2182047
set path=%path%;C:\Program Files\7-Zip
set file=%1
for /f "tokens=1,3 delims= " %%g in ('7z.exe l -slt %file%') do (  
  echo.%%g | findstr /b /c:"Path" 1>nul
  if NOT errorlevel 1 (
      echo.%%h >> %file%.txt
	  REM to extract infromation from filename
	  REM FOR %%i IN (%%h) DO (		
	  REM ECHO %%~xi >> list.txt	  
	  REM )	  	  
  )  
)
