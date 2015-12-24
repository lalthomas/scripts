@echo OFF
REM Author Lal Thomas (lal.thomas.mail@gmail.com)
REM get the script folder path
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

setlocal
%~d1
cd "%~p1"
REM Thanks you http://stackoverflow.com/a/2541820
IF [%~x1] == [] ( 
IF EXIST %1 ( CALL:FOLDER "%CD%" )
) ELSE ( 
IF EXIST %1 ( CALL:MAP %1 )
)
REM premature exit to define functions beneath
EXIT /B %ERRORLEVEL%

REM Subroutine
:MAP
REM echo %1
if /i %~x1 == .c ( goto CGROUP )
if /i %~x1 == .cpp ( goto CGROUP )
if /i %~x1 == .cs ( goto CGROUP )
if /i %~x1 == .java ( goto CGROUP )
if /i %~x1 == .html ( goto  HTML )
if /i %~x1 == .htm ( goto HTML )
if /i %~x1 == .xml ( goto  XML )
if /i %~x1 == .css ( goto CSS)
if /i %~x1 == .php ( goto PHP)
EXIT /b 0

REM Section
:CGROUP
REM C,C++,C#,Java
set path=%PATH%;"%scriptFolderPath%\tools\astyle\"
REM The following two line are Npp Hack for not changing the current path
call astyle --style=gnu %1
IF %ERRORLEVEL% EQU 0 ( del %1.orig ) ELSE ( pause echo lexical error in program %~nx1 )
EXIT /b 0

REM Section
:HTML
REM HTML
@echo OFF
set tempFile="%~n1.tmp.html"
copy %1 %tempFile%
set path=%PATH%;"%scriptFolderPath%\tools\htb"
htb.exe -l4 %1 %tempFile%
IF %ERRORLEVEL% EQU 0 (   
  move /Y %tempFile% %1  
) ELSE (
  echo lexical error in program %~nx1
  pause
  )
EXIT /b 0

REM Section
:XML
REM HTML
copy %1 "%scriptFolderPath%\temp.xml"
set path=%PATH%;"%scriptFolderPath%\tools\xml-indent"
REM The following two line are Npp Hack for not changing the current path
call xmlindent -o %1 %scriptFolderPath%\temp.xml 
EXIT /b 0

:CSS
REM CSS
copy %1 "%scriptFolderPath%\temp.css"
set path=%PATH%;"%scriptFolderPath%\tools\css-tidy"
@echo OFF
REM The following two line are Npp Hack for not changing the current path
cls
echo Beautify CSS Options
echo .....................................................
echo 1. Readabity $-------- Compression
echo 2. Readabity ----$---- Compression
echo 3. Readabity --------$ Compression
echo .....................................................
SET /p _Opt=Enter your choice : 
@echo ON
SET _OptValue= "--template=low"
IF /I "%_Opt%" == "1" ( SET _OptValue= --template=low)
IF /I "%_Opt%" == "2" ( SET _OptValue= --template=medium)
IF /I "%_Opt%" == "3" ( SET _OptValue= --template=high)
call csstidy "%scriptFolderPath%\temp.css" --timestamp=false --allow_html_in_templates=false --compress_colors=false --compress_font=false --lowercase_s=true --preserve_css=true --remove_last_;=false --remove_bslash=false --sort_properties=true --sort_selectors=false --case_properties=0 %_OptValue% %1
IF %ERRORLEVEL% NOT EQU 0 (copy "%scriptFolderPath%\temp.css" %1 )
pause
EXIT /b 0


:PHP
set tempFile="%~n1.tmp.php"
copy %1 %tempFile%
set path=%PATH%;"%scriptFolderPath%\tools\phpcb"
call phpcb --align-equal-statements --space-after-if --space-after-switch --space-after-while --space-after-end-angle-bracket --space-before-start-angle-bracket --change-shell-comment-to-double-slashes-comment --force-large-php-code-tag --glue-amperscore --force-true-false-null-contant-lowercase --one-true-brace-function-declaration --comment-rendering-style PEAR %1 >%tempFile%
IF %ERRORLEVEL% EQU 0 (   
  move /Y %tempFile% %1  
) ELSE (
  echo lexical error in program %~nx1
  pause
  )
del %tempFile%
EXIT /b 0


:FOLDER
SET /p _Opt="Are you sure to beautify all files on the folder(y/n)" 
IF "%_Opt%" == "n" ( goto :EOF)
echo Batch Processing folder... : %1 
for %%a in ("%CD%"\*.*) do ( CALL:MAP "%%a" )
EXIT /b 0

REM pause
endlocal