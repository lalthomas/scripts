@echo OFF
setlocal 
REM Before using this batch please download PanDoc from https://pandoc.googlecode.com/files/pandoc-1.11b.msi
set HOME=D:\lalthomas\Dev\20130307-Mail (lalthomas)

set /p DOC=Enter todays doc name (without md extension): 

REM Get the current date
for /F "tokens=1* delims= " %%A in ('date /T') do set CDATE=%%B
for /F "tokens=1,2 eol=/ delims=/ " %%A in ('date /T') do set mm=%%B
for /F "tokens=1,2 delims=/ eol=/" %%A in ('echo %CDATE%') do set dd=%%B
for /F "tokens=2,3 delims=/ " %%A in ('echo %CDATE%') do set yyyy=%%B
set date=%yyyy%%mm%%dd%
echo %date% : Creating HTML,PDF pages....

REM Creating Documents...
set path=%path%;C:\Users\Administrator\AppData\Local\Pandoc
pandoc "%HOME%\pages\%DOC%.md" -o "%HOME%\publish\%DOC%.html"

IF EXIST "%DOC% (review).pdf" goto FILE_EXSITS
pandoc -S "%HOME%\pages\%DOC%.md" -o "%HOME%\publish\%DOC% (review).pdf"
goto CHECK_END
:FILE_EXSITS
pandoc -S "%HOME%\pages\%DOC%.md" -o "%HOME%\publish\%DOC%.pdf"
:CHECK_END

REM wkhtmltopdf
set path=%path%;C:\Program Files\wkhtmltopdf
REM wkhtmltopdf "%HOME%\publish\%DOC%.html" "%HOME%\publish\%DOC% (review).pdf"

endlocal
pause