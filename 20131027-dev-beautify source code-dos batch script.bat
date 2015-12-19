@echo OFF
REM Author Lal Thomas (lal.thomas.mail@gmail.com)

REM get the script folder path
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

setlocal
if /i %~x1 == .c ( goto CGROUP )
if /i %~x1 == .cpp ( goto CGROUP )
if /i %~x1 == .cs ( goto CGROUP )
if /i %~x1 == .java ( goto CGROUP )
if /i %~x1 == .html ( goto  HTML )
if /i %~x1 == .htm ( goto HTML )
if /i %~x1 == .xml ( goto  XML )
if /i %~x1 == .css ( goto CSS)
goto EOF

:CGROUP
REM C,C++,C#,Java
set path=%PATH%;"%scriptFolderPath%\tools\astyle\"
REM The following two line are Npp Hack for not changing the current path
%~d1
cd "%~p1"
cls
call astyle --style=gnu %1
IF %ERRORLEVEL% EQU 0 (del %1.orig) ELSE (pause echo Lexical Error in Program )
goto EOF

:HTML
REM HTML
copy %1 %scriptFolderPath%\temp.html
set path=%PATH%;"%scriptFolderPath%\tools\htb"
REM The following two line are Npp Hack for not changing the current path
%~d1
cd "%~p1"
cls
call htb /ablns4 %scriptFolderPath%\temp.html %1
goto EOF

:XML
REM HTML
copy %1 "%scriptFolderPath%\temp.xml"
set path=%PATH%;"%scriptFolderPath%\tools\xml-indent"
REM The following two line are Npp Hack for not changing the current path
%~d1
cd "%~p1"
cls
call xmlindent -o %1 %scriptFolderPath%\temp.xml 
goto EOF

:CSS
REM CSS
copy %1 "%scriptFolderPath%\temp.css"
set path=%PATH%;"%scriptFolderPath%\tools\css-tidy"
@echo OFF
REM The following two line are Npp Hack for not changing the current path
%~d1
cd "%~p1"
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
goto EOF

REM pause
EOFlocal