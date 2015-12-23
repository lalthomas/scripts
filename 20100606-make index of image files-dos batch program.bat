setlocal
@echo ON
REM get the script folder path
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%
set "headerFilePath=\templates\20151223-image file index template 01.html"
set "footerFilePath=\templates\20151223-image file index template 02.html"
set filename=temp.html

set path=%PATH%;%~dp1
%~d1
cd %~dp1

type "%scriptFolderPath%%headerFilePath%" >%filename%
for %%f in (%*) do (
  echo ^<p^>^<span style^=^"background-image:url^(^'%%~nxf^'^);^"^>^</span^>^<a href^=^"^'%%~nxf^'^"^>%%~nxf^<^/a^>^<^/p^> >>%filename%
)
type "%scriptFolderPath%%footerFilePath%" >>%filename%

pause
endlocal