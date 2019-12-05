@echo OFF
setlocal 
REM Before using this batch please download PanDoc from https://pandoc.googlecode.com/files/pandoc-1.11b.msi
set HOME=D:\lalthomas\Dev\20130307-Mail (lalthomas)
set THUNDERBIRD_HOME=C:\Program Files\Mozilla Thunderbird\
set /p DOC=Enter today's doc name (without md extension): 

REM Get the current date
for /F "tokens=1* delims= " %%A in ('date /T') do set CDATE=%%B
for /F "tokens=1,2 eol=/ delims=/ " %%A in ('date /T') do set mm=%%B
for /F "tokens=1,2 delims=/ eol=/" %%A in ('echo %CDATE%') do set dd=%%B
for /F "tokens=2,3 delims=/ " %%A in ('echo %CDATE%') do set yyyy=%%B
set date=%yyyy%%mm%%dd%
echo %date% : Preparing review mail for today
call "%THUNDERBIRD_HOME%\thunderbird.exe" -compose "to='vinayakh@rapidvaluesolutions.com',subject='%DOC%',body='Hi guys,<br/>please review the attached [%DOC%.pdf] document within 15 minutes <br/> Thank You <br/> Lal Thomas',attachment='%HOME%\publish\%DOC% (review).pdf'"
endlocal