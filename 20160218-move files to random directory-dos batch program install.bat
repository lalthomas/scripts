@echo OFF 	
REM File : 20160218-move files to random directory-dos batch program install.bat 	
REM Creation Date : 2019-11-27 	
REM Author : Lal Thomas 	
REM Original File : 20160218-move files to random directory-dos batch program.bat 	
	
REM Thanks http://stackoverflow.com/a/19706067/2182047
REM Original modified for need
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "longdatestamp=%YYYY%-%MM%-%DD%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

IF [%1] == [] GOTO :SETFILE
set file=%1
GOTO :EXECUTE

:SETFILE

set file="%scriptFolderPath%\20160218-move files to random directory-dos batch program.bat"
GOTO :EXECUTE

REM Section
:EXECUTE
call :createShortCut "%CD%\20160218-move files to random directory-dos batch program.bat" "# explorer - move files to random directory.lnk"
exit

:createShortCut
set scriptfile=".\20170102-create shortcut in sendto folder-powershell script.ps1"
IF [%3] == [] (
	powershell -STA -executionpolicy bypass -File %scriptfile% -filename %1 -linkname %2 
) ELSE (
	powershell -STA -executionpolicy bypass -File %scriptfile% -filename %1 -linkname %2 -switch %3
)
exit /b 0