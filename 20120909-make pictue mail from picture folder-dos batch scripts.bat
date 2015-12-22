@echo OFF

REM ****************************************************
REM Script to get the last folder in the file path
REM Credit : http://stackoverflow.com/questions/2396003/get-parent-directory-name-for-a-particular-file-using-dos-batch-scripting
setlocal

REM get the script folder path
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

set path=%PATH%;%~dp1
%~d1
cd %~dp1

set fileName="index.eml"

echo From - Wed Jul 18 11\:06\:40 2012 >%fileName%                                                                       
REM ****************************************************
echo Message-ID: ^<50064B68.2070405@gmail.com^> >>%fileName%
echo Date: Wed, 18 Jul 2012 11:06:40 +0530 >>%fileName%
echo MIME-Version: 1.0 >>%fileName%
echo Subject: $SUBJECT$ >>%fileName%
echo Content-Type: multipart/related; >>%fileName%
echo  boundary=^"------------090109080102010402080505^" >>%fileName%
echo.>>%fileName%
echo This is a multi-part message in MIME format. >>%fileName%
echo --------------090109080102010402080505 >>%fileName%
echo Content-Type: text/html; charset=ISO-8859-1 >>%fileName%
echo Content-Transfer-Encoding: 7bit >>%fileName%
echo.>>%fileName%
echo ^<html^>^<head^>^<meta http-equiv=^"content-type^" content=^"text/html; charset=ISO-8859-1^"^>^<title^>%ParentDir%^</title^> ^</head^>^<body^> >>%fileName%
echo  ^<div align=^"center^"^> >>%fileName%
echo ^<h1^> $SUBJECT$ ^</h1^> >>%fileName%

REM ------------------------
set /a s=1
REM To enable looop count
setlocal ENABLEDELAYEDEXPANSION
setlocal
for %%f in (%*) do (
  REM Extracts the IPTC Caption of the image
  call "%scriptFolderPath%\tools\exiftool\exiftool.exe" -iptc:Caption-Abstract %%f >captionimage.txt
  for /f "delims=" %%x in (captionimage.txt) do echo ^<p style=^'text-align:left;^'^>%%x^</p^> >>%fileName%
  echo ^<p^>^</p^> >>%fileName%
  REM Must use !s! for delayed expansion
  echo ^<img src=^"cid:part!s!.01030501.02050408@gmail.com^" alt=^"^"^> >>%fileName%
  set /a s=s+1
  del captionimage.txt
)

REM ------------------------ 
 
echo ^</div^> >>%fileName%
echo ^</body^>^</html^> >>%fileName%
call "%scriptFolderPath%\tools\fart\fart.exe" %fileName% "<p style='text-align:left;'>Caption-Abstract                : " "<p style='text-align:left;'>"

REM Loop through all images in the folder
set /a s=1
REM To enable looop count
setlocal ENABLEDELAYEDEXPANSION
setlocal
for %%f in (%*) do (
  REM echo %1
  echo --------------090109080102010402080505 >>%fileName%
  echo Content-Type: image/jpeg; >>%fileName%
  echo  name=^"%%f^" >>%fileName%
  echo Content-Transfer-Encoding: base64 >>%fileName%
  REM Must use !s! for delayed expansion
  echo Content-ID: ^<part!s!.01030501.02050408@gmail.com^> >>%fileName%
  set /a s=s+1
  echo Content-Disposition: inline; >>%fileName%
  echo  filename=^"%%f^" >>%fileName%
  echo.>>%fileName% >>%fileName%
  
  REM Encodes the image to Base64 encoding
  "%scriptFolderPath%\tools\base64\base64.exe" -e %%f "encodeimage.txt"
  type encodeimage.txt>>%fileName%
  REM call :getcaption %caption%
  
  REM Clean Up
  del encodeimage.txt
)


REM warning !!! : never change the position of the code - high side effect

REM ------------------------------
REM take the parent folder path
setlocal
set ParentDir=%~p1
set ParentDir=%ParentDir: =:%
set ParentDir=%ParentDir:\= %
call :getparentdir %ParentDir%
set ParentDir=%ParentDir::= %
goto :MADE_FOLDER
:getparentdir
if "%~1" EQU "" goto :MADE_FOLDER
Set ParentDir=%~1
shift
goto :getparentdir
:MADE_FOLDER
set ParentDir=%ParentDir::= %
REM ------------------------------

ren %fileName% "%ParentDir%.eml"
del %fileName%
call "%scriptFolderPath%\tools\fart\fart.exe" "%ParentDir%.eml" "$SUBJECT$" "%ParentDir%"

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
exit
