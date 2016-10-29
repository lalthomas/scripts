@echo OFF
REM to echo unicode character
chcp 65001>NUL
call :createInboxFolder "Checked"
call :createInboxFolder "æœ« "
call :createInboxFolder "Î©"
exit /b 1

:createInboxFolder
md %1
ATTRIB +s %1
REM path push
pushd %1

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

REM path pop 
popd

REM reverse to prev code page
chcp 65001>NUL

exit /b 1