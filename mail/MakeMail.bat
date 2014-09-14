@echo OFF

REM ****************************************************
REM Script to get the last folder in the file path
REM Credit : http://stackoverflow.com/questions/2396003/get-parent-directory-name-for-a-particular-file-using-dos-batch-scripting
setlocal
set path=%PATH%;E:\Devel\Mis\MakeMail
REM set ParentDir=%~p1
set ParentDir=%CD%
REM echo %ParentDir%

REM Replaces every space with colon
set ParentDir=%ParentDir: =:%
REM echo %ParentDir%

REM Replaces every back slash with space
set ParentDir=%ParentDir:\= %
REM echo %ParentDir%

REM Calls a routine that calculates the last folder
call :getparentdir %ParentDir%

REM Replaces every colon with space
set ParentDir=%ParentDir::= %
REM echo ParentDir is %ParentDir%

echo From - Wed Jul 18 11:06:40 2012 >index.eml                                                                              
echo Message-ID: ^<50064B68.2070405@gmail.com^> >>index.eml
echo Date: Wed, 18 Jul 2012 11:06:40 +0530 >>index.eml
echo MIME-Version: 1.0 >>index.eml
echo Subject: %ParentDir% >>index.eml

echo Content-Type: multipart/related; >>index.eml
echo  boundary=^"------------090109080102010402080505^" >>index.eml
echo.>>index.eml
echo This is a multi-part message in MIME format. >>index.eml
echo --------------090109080102010402080505 >>index.eml

echo Content-Type: text/html; charset=ISO-8859-1 >>index.eml
echo Content-Transfer-Encoding: 7bit >>index.eml
echo.>>index.eml
echo ^<html^>^<head^>^<meta http-equiv=^"content-type^" content=^"text/html; charset=ISO-8859-1^"^>^<title^>%ParentDir%^</title^> ^</head^>^<body^> >>index.eml

echo ^<h1^> %ParentDir% ^</h1^> >>index.eml
echo  ^<div align=^"center^"^> >>index.eml

set /a s=1
REM To enable looop count
setlocal ENABLEDELAYEDEXPANSION
for %%a in ( *.jpg,*.png,*.gif ) do (
REM Extracts the IPTC Caption of the image
call exiftool -iptc:Caption-Abstract "%%a" >captionimage.txt
for /f "delims=" %%x in (captionimage.txt) do echo ^<p style=^'text-align:left;^'^>%%x^</p^> >>index.eml
echo ^<p^>^</p^> >>index.eml
REM Must use !s! for delayed expansion
echo ^<img src=^"cid:part!s!.01030501.02050408@gmail.com^" alt=^"^"^> >>index.eml
set /a s=s+1
del captionimage.txt
)
echo ^</div^> >>index.eml
echo ^</body^>^</html^> >>index.eml
call fart index.eml "<p style='text-align:left;'>Caption-Abstract                : " "<p style='text-align:left;'>"


REM Loop through all images in the folder
set /a s=1
REM To enable looop count
setlocal ENABLEDELAYEDEXPANSION
for %%a in ( *.jpg,*.png,*.gif ) do (
echo --------------090109080102010402080505 >>index.eml
echo Content-Type: image/jpeg; >>index.eml
echo  name=^"%%a^" >>index.eml
echo Content-Transfer-Encoding: base64 >>index.eml
REM Must use !s! for delayed expansion
echo Content-ID: ^<part!s!.01030501.02050408@gmail.com^> >>index.eml
set /a s=s+1
echo Content-Disposition: inline; >>index.eml
echo  filename=^"%%a^" >>index.eml
echo.>>index.eml >>index.eml

REM Encodes the image to Base64 encoding
base64 -e "%%a" "encodeimage.txt"
type encodeimage.txt>>index.eml
REM call :getcaption %caption%

REM Clean Up
del encodeimage.txt
)
endlocal
REM pause

del "%ParentDir%.eml"
ren "index.eml" "%ParentDir%.eml"

goto :EOF

REM Routine that remove the first part of the string separated by colon
setlocal
:getcaption
echo %*
shift
set caption=%~1
goto :EOF
endlocal
REM End of Script
REM ****************************************************


REM Routine that returns the last word of the string
setlocal
:getparentdir
if "%~1" EQU "" goto :EOF
Set ParentDir=%~1
shift
goto getparentdir
endlocal


