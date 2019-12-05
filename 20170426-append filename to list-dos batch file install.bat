@echo OFF 	
REM File : 20170426-append filename to list-dos batch file install.bat 	
REM Creation Date : 2019-11-27 	
REM Author : Lal Thomas 	
REM Original File : 20170426-append filename to list-dos batch file.bat 	
	
REM Thanks http://stackoverflow.com/a/19706067/2182047
REM Original modified for need
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "longdatestamp=%YYYY%-%MM%-%DD%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

IF [%1] == [] GOTO :SETFILE
set file=%1
GOTO :EXECUTE

:SETFILE
set file="%~dp020170426-append filename to list-dos batch file.bat"
GOTO :EXECUTE

REM Section
:EXECUTE
call :createShortCut "%CD%\20170426-append filename to list-dos batch file.bat" "# +book.lnk" "D:\do\%YYYY%\reference\lalthomas favourite book list.txt"
call :createShortCut "%CD%\20170426-append filename to list-dos batch file.bat" "# +film.lnk" "D:\do\%YYYY%\reference\lalthomas favourite films playlist.m3u"
call :createShortCut "%CD%\20170426-append filename to list-dos batch file.bat" "# +image.lnk" "D:\do\%YYYY%\reference\lalthomas favourite image list.txt"
call :createShortCut "%CD%\20170426-append filename to list-dos batch file.bat" "# +music.lnk" "D:\do\%YYYY%\reference\lalthomas favourite music playlist.m3u"
call :createShortCut "%CD%\20170426-append filename to list-dos batch file.bat" "# +people.lnk" "D:\do\%YYYY%\reference\lalthomas favourite people list.txt"
call :createShortCut "%CD%\20170426-append filename to list-dos batch file.bat" "# +video.lnk" "D:\do\%YYYY%\reference\lalthomas favourite video playlist.m3u"
pause
exit /b 0

:createShortCut
set scriptfile=".\20170102-create shortcut in sendto folder-powershell script.ps1"
IF [%3] == [] (
	powershell -STA -executionpolicy bypass -File %scriptfile% -filename %1 -linkname %2 
) ELSE (
	powershell -STA -executionpolicy bypass -File %scriptfile% -filename %1 -linkname %2 -switch %3
)
exit /b 0