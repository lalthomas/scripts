@echo OFF
setlocal

REM find script folder 
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

REM The following two line are Npp Hack for not changing the current path
%~d1
cd %~p1

Setlocal EnableDelayedExpansion
set "supportfiletype=%~2"
set originalpath=%~1
set originalfilename=%~nx1
set filename=%~n1 %supportfiletype%
set fullpath=%~dp1%filename%
REM add quotes
set filename="%filename%"
set fullpath="%fullpath%"

REM Thanks http://stackoverflow.com/a/19706067/2182047
REM Original modified for need
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "longdatestamp=%YYYY%-%MM%-%DD%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

if exist %filename% ( "%PROGRAMFILES%\Notepad++\notepad++.exe" %fullpath% ) else ( CALL :CONFIRM )
exit /b 0
endlocal

:CONFIRM
setlocal
set /p _Opt="%filename% doesn't exist do you want to create (y/n) :"	
IF /I "%_Opt%" == "y" ( CALL :NEWFILE %filename% )
endlocal
exit /b 0

:NEWFILE
Setlocal EnableDelayedExpansion
set "SUBJECT=%~1"
set "runTemplateFilePath=\templates\20170331-run support file.txt"	

@echo OFF

if /I "%supportfiletype%" == "readme.md" (				
	echo %% %SUBJECT% >>%filename% ^
	&& echo %% %longdatestamp% >>%filename% ^
	&& echo %% Lal Thomas >>%filename% ^
	&& echo %% %originalfilename% >>%filename% ^
	&& echo.>>%filename% ^
	&& "%PROGRAMFILES%\Notepad++\notepad++.exe" %fullpath%	
	
) else if /I "%supportfiletype%" == "run.bat" (
	
	echo ^@echo OFF >>%filename% ^
	&& echo ^REM File : %SUBJECT% >>%filename% ^
	&& echo ^REM Creation Date : %longdatestamp% >>%filename% ^
	&& echo ^REM Author : Lal Thomas >>%filename% ^
	&& echo ^REM Original File : %originalfilename% >>%filename% ^
	&& echo.>>%filename%	
	type "%scriptFolderPath%%runTemplateFilePath%" >>%filename%
	call "%scriptFolderPath%\tools\fart\fart.exe" %fullpath% "$FULLPATH$" "\"%originalpath%\"" >nul 2>nul
	"%PROGRAMFILES%\Notepad++\notepad++.exe" %fullpath%	
)


REM add to readme file without quotes
echo %filename:"=% >>readme.md
REM add to revision control
set filenoquote=%filename:"=\"%
set commitmessage="create %filenoquote% file and add it to 'readme.md' file listing section"
git add %filename% "readme.md"
git commit -m %commitmessage%
endlocal
exit /b 0
