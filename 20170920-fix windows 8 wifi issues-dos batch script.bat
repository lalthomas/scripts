@echo OFF

set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

REM get admin previllage for the batch
REM thanks : https://stackoverflow.com/a/10052222/2182047

REM Check for permissions
REM	--------------------- 

IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" ( 
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system" 
) ELSE ( 
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" 
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( 
	goto gotAdmin 
)


:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

REM --------------------------------------

REM Hack Start

IPCONFIG /FLUSHDNS
NETSH INT IP RESET C:RESTLOG.TXT
NETSH INT TCP SET HEURISTICS DISABLED
NETSH INT TCP SET GLOBAL AUTOTUNINGLEVEL=DISABLED
NETSH INT TCP SET GLOBAL RSS=ENABLED
shutdown /r
pause