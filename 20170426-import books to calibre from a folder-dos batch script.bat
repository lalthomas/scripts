@echo ON
setlocal

REM TODO loop over all files in folder passed as arguement to the script
REM TODO move the files to recycle bin after successful import 
REM create a catalogue of files with inbox field set to FALSE 
REM move the files to main library after processing
REM update the catalogue

set library="%~2"

REM Thanks you http://stackoverflow.com/a/2541820
IF [%~x1] == [] ( 
IF EXIST %1 ( CALL:FOLDER %1 )
) 
REM premature exit to define functions beneath
EXIT /B %ERRORLEVEL%

:FOLDER
REM SYNTAX calibre [options] [path_to_ebook]
for %%a in (%1\*.pdf) do ( call :addbooks "%%a" )
goto :END
endlocal
pause

:addbooks
calibredb add --library-path %library% --title "%~n1"  "%~1"
REM get the bookid
for /f "delims=" %%A in ('calibredb search --library-path "D:\temp\20170426" --limit "1" "%~n1"') do set "bookid=%%A"

REM -------------------
REM Update the metadata
REM -------------------
REM SYNTAX calibredb set_metadata [options] id [/path/to/metadata.opf]
calibredb set_metadata --library-path %library% --field "authors:Lal" %bookid%
calibredb set_custom --library-path %library% inbox %bookid% 1
calibredb set_custom --library-path %library% read %bookid% 0
pause
exit /b 0
REM END OF PROGRAM
:END
