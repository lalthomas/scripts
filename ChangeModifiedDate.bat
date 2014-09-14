@ECHO ON
REM * MODIFIED.BAT, Version 1.01
REM * Check if specified file was created or modified today
REM * Written by Rob van der Woude
REM * http://www.robvanderwoude.com

REM * Needs write access to current directory; or add fully qualified
REM * path to files CURRENT.BAT and its language dependent versions,
REM * and make sure its path is specified in the PATH variable.

REM * File name should be specified
IF "%1"=="" GOTO Syntax
IF NOT EXIST %1 GOTO Syntax

REM * Send DIR output for specified file to primary temporary
REM * batch file to get the file's creation or modification date
DIR %1 | FIND /I "%1" > %TEMP%.\~ISMODIF.TMP
ECHO.>> %TEMP%.\~ISMODIF.TMP
TYPE %TEMP%.\~ISMODIF.TMP | TIME | FIND /I "%1" > %TEMP%.\~ISMODIF.BAT
REM * Create secondary temporary batch files to be called by primary
ECHO SET CHKDATE=%%4>ENTER.BAT
REM * For Dutch DOS versions
ECHO SET CHKDATE=%%5>VOER.BAT
ECHO SET CHKDATE=%%6>TYP.BAT
CALL %TEMP%.\~ISMODIF.BAT

REM * Send DIR output for temporary batch file to itself to get today's date
DIR %TEMP%.\~ISMODIF.BAT | FIND /I "~ISMODIF.BAT" > %TEMP%.\~ISMODIF.TMP
ECHO.>> %TEMP%.\~ISMODIF.TMP
TYPE  %TEMP%.\~ISMODIF.TMP | TIME | FIND /I "~ISMODIF.BAT" > %TEMP%.\~ISMODIF.BAT
REM * Create secondary temporary batch files to be called by primary
ECHO SET NOWDATE=%%4>ENTER.BAT
REM * For Dutch DOS versions
ECHO SET NOWDATE=%%5>VOER.BAT
ECHO SET NOWDATE=%%6>TYP.BAT
CALL %TEMP%.\~ISMODIF.BAT

REM * Compare dates and display result
IF "%NOWDATE%"=="%CHKDATE%" ECHO %1 was created or modified today (%NOWDATE%)

REM * Clean up the mess
DEL %TEMP%.\~ISMODIF.BAT
DEL %TEMP%.\~ISMODIF.TMP
DEL ENTER.BAT
DEL VOER.BAT
DEL TYP.BAT
SET CHKDATE=
SET NOWDATE=
GOTO End

:Syntax
ECHO MODIFIED,  Version 1.01
ECHO Check if specified file was created or modified today
ECHO Written by Rob van der Woude
ECHO http://www.robvanderwoude.com
ECHO.
ECHO.
ECHO Usage:  %0  filename

:End