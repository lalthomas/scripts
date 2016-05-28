setlocal
@echo OFF
REM get the script folder path

REM Script to get the attributes of file
for /f "skip=5 tokens=1-8 delims=/: " %%a in ('dir /tC %1') do (
     set mon=%%a      
     set day=%%b
     set yyyy=%%c
     set hh=%%d
     set min=%%e
     set filename=%%h
     goto receiveDateTimeString
)
:receiveDateTimeString
set mon=%mon: =%
set datetime=%yyyy%%mon%%day%-%hh%%min%

REM find script folder 
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

set "headerFilePath=\templates\20151223-image file index template 01.html"
set "footerFilePath=\templates\20151223-image file index template 02.html"

set filename=%datetime%-index.html

set path=%PATH%;%~dp1
%~d1
cd %~dp1

type "%scriptFolderPath%%headerFilePath%" >%filename%
for %%f in (%*) do (
  echo ^<p^>^<span style^=^"background-image:url^(^'%%~nxf^'^);^"^>^</span^>^<a href^=^"%%~nxf^"^>%%~nxf^<^/a^>^<^/p^> >>%filename%
)
type "%scriptFolderPath%%footerFilePath%" >>%filename%

REM pause
endlocal