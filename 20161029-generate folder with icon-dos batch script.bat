@echo OFF
setlocal
REM argument one - destination folder
REM argument two - name list
if [%1]==[] (

	echo.
	echo Script Error
	echo Please pass arguments
	echo Format
	echo.
	echo  ^<scriptname^> ^<destination-folder^> ^<namelist-filename^>
	exit /b 1
) 

if [%2]==[] (

	echo.
	echo Script Error
	echo Please pass arguments
	echo Format
	echo.
	echo ^<scriptname^> ^<destination-folder^> ^<namelist-filename^>
	exit /b 1

)

%~d1
cd %~dp1
REM to echo unicode character
chcp 65001>NUL
REM Sample calls
REM call :createIconFolder "æœ« "
REM call :createIconFolder "Î©"

echo.
echo %~dpnx1
echo.
for /f "delims=" %%a in ('type %2') do (	
	call :createIconFolder "%%a"
	echo  SUCCESS: folder %%a  created
)
exit /b 1

:createIconFolder
md "%~1"
ATTRIB +s %~1
cd %1
REM prepare desktop config file
(
echo ^[.ShellClassInfo^]
echo IconResource^=C:^\WINDOWS^\system32^\SHELL32.dll,301
echo ^[ViewState^]
echo Mode^=
echo Vid^=
echo FolderType^=Generic
)>"desktop.txt"

REM following make a refresh of explorer
REM thanks : http://stackoverflow.com/a/6279348/2182047
CHCP 1252 >NUL
CMD.EXE /D /A /C (SET/P=ÿþ)<NUL > desktop.ini 2>NUL
CMD.EXE /D /U /C TYPE desktop.txt >> desktop.ini
DEL /F /Q desktop.txt
ATTRIB +S +H desktop.ini

REM path exit 
cd ..

REM reverse to prev code page
chcp 65001>NUL

exit /b 1