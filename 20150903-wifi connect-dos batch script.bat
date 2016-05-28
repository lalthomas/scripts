@echo off
CLS
:MENU
ECHO Press 1, 2, or 3 to select your task, or 4 to Exit.
ECHO.
ECHO 1 Set Wifi Sharing Attributes
ECHO 2 Start WiFi Sharing
ECHO 3 Stop WiFi Sharing
ECHO 4 Exit
ECHO.
SET /P M=Type 1, 2, 3, or 4, then press ENTER:
IF %M%==1 GOTO SET
IF %M%==2 GOTO START
IF %M%==3 GOTO STOP
IF %M%==4 GOTO EOF
:SET
netsh wlan set hostednetwork mode=allow ssid=HackWin key=connect2Wifi keyusage=persistent
GOTO MENU
:START
netsh wlan start hostednetwork
GOTO MENU
:STOP
netsh wlan stop hostednetwork
GOTO MENU
:EOF
