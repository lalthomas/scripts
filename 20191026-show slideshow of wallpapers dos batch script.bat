@echo ON
setlocal
REM Author : Lal Thomas
REM Date   : 2019-10-26

set ViewerPath="E:\PortableApps.com\PortableApps\IrfanViewPortable\IrfanViewPortable.exe"
set filelist="%USERPROFILE%\Desktop\slideshow.txt"
IF NOT EXIST %filelist% ( call :PREPARE )
%ViewerPath% /closeslideshow /slideshow=%filelist% 
REM del %filelist%
endlocal
pause
exit /b 0

:PREPARE
set rootfolder="F:\box"
pushd %rootfolder%
@echo ON
for /f "tokens=*" %%f in ('dir /b /tA /OD /A:D') do ( call :GENFILELIST %%~dpnxf )
exit /b 0
popd


:GENFILELIST
set picfolderpath="%1\pictures"
IF EXIST %picfolderpath% ( 
	pushd %picfolderpath%
	dir /s /b /tA /OD *.jpg >>%filelist%
	popd
)
exit /b 0