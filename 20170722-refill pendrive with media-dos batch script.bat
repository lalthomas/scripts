@echo OFF
setlocal EnableDelayedExpansion
REM 20170722-refill pendrive with media-dos batch script.bat
REM Lal Thomas
REM 2017-07-22

REM set variables
set playlistfile="%~1"
set playlistfolder="%~dp1"
set playlistsyncfile="%~dpn1-sync-list%~x1"
set watchedplaylistfile="%~2"
set targetpath="%~3"
set excludepattern=%~4

REM find script folder 
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

REM Thanks http://stackoverflow.com/a/19706067/2182047
REM Orginal modified for need
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "longdatestamp=%YYYY%-%MM%-%DD%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

REM move the current files in pen drive playlist to watched.txt
call :MOVEWACTCHED
REM select the playlist to sync with
set choosedpath=""
call :SELECTPLAYLIST 

REM move 100 listings from the chosen file
REM copy the files to pendrive location
REM move contends of sync playlist to drive playlist
call "%scriptFolderPath%\20170722-move n lines of a file and append to another file-powershell script run.bat" %choosedpath% %playlistsyncfile% "5" ^
&& call "%scriptFolderPath%\20140222-copy files from a list of files-dos batch script.bat" %playlistsyncfile% %targetpath% ^
&& call "%scriptFolderPath%\20170722-move contends of a file to another file-dos batch script.bat" %playlistsyncfile% %playlistfile% ^
&& del %playlistsyncfile%

echo "Refill complete ..."
pause
endlocal
exit /b 0

:MOVEWACTCHED
REM thanks : https://stackoverflow.com/a/5006393/2182047
REM append comment character and date string to each line
for /f "usebackq  tokens=* delims= " %%a in (%playlistfile%) do (	
	echo # %longdatestamp% %%a >>%watchedplaylistfile%
)

REM remove the contends of playlist
echo.>%playlistfile%
exit /b 0


:SELECTPLAYLIST
REM change to playlist folder
pushd %playlistfolder%
REM show the list of files
set /a count=0
set dircmd="dir /b *.m3u | findstr /v /i %excludepattern%"
for /f "usebackq tokens=* delims=" %%x in (`%dircmd%`) do (
	set /a count=count+1
	set choice[!count!]=%%~x
)
echo.
echo Select one:
echo.
REM Print list of files
for /l %%x in (1,1,!count!) do (
   echo %%x	!choice[%%x]!
)
echo.
REM Retrieve User input
set /p select="please select a file : "
echo.
echo You chose:  !choice[%select%]!
REM remove unnecessary quotes
set choosedpath="%playlistfolder%!choice[%select%]!"
set choosedpath="%choosedpath:"=%"
REM remove from stack
popd
exit /b 0

