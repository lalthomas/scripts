@echo OFF 	
REM File : 20131027-dev-beautify source code-dos batch script install.bat 	
REM Creation Date : 2019-11-27 	
REM Author : Lal Thomas 	
REM Original File : 20131027-dev-beautify source code-dos batch script.bat 	
	
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
set file="%scriptFolderPath%\20131027-dev-beautify source code-dos batch script.bat"
GOTO :EXECUTE

REM Section
:EXECUTE
call :createShortCut "%CD%\20131027-dev-beautify source code-dos batch script.bat" "# dev - beautify.lnk"

REM create context menu entry on windows explorer
set regentry=%file%
set regentry=%regentry:\=\\%
set regentry=%regentry:"=%
REM add to explorer context menu
REM Need to run this as administrator
REG ADD "HKCR\*\Shell\Beautify\Command" /D "\"%regentry%\" \"%%%11\"" /T REG_SZ /F 
:: Make the changes effective immediately
%SystemRoot%\System32\RUNDLL32.EXE user32.dll, UpdatePerUserSystemParameters

exit /b 0

:createShortCut
set scriptfile=".\20170102-create shortcut in sendto folder-powershell script.ps1"
IF [%3] == [] (
	powershell -STA -executionpolicy bypass -File %scriptfile% -filename %1 -linkname %2 
) ELSE (
	powershell -STA -executionpolicy bypass -File %scriptfile% -filename %1 -linkname %2 -switch %3
)
exit /b 0