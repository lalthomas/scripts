setlocal
@echo OFF
set /a s=1
:CheckPoint
if "%~n1%~x1" == "Pattern_%s%%~x1" ( goto END)
if EXIST "Pattern_%s%%~x1" (set /a s=s+1) ELSE (goto RENAM)
goto CheckPoint
:RENAM
REN %1 "Pattern_%s%%~x1"

:Check1
if EXIST "Pattern_%s%%~x1" (set /a s=s+1) ELSE (goto Contin)
goto Check1

:Contin
if /i "%~x1" == ".png" ( goto PNG )
if /i "%~x1" == ".jpg" ( goto JPG )
if /i "%~x1" == ".gif" ( goto GIF )
:PNG
IF NOT EXIST Index-PNG.html ( copy "E:\Devel\Mis\Index-PNG.html" "%CD%\Index-PNG.html" )
set path=%path%;"E:\Devel\Mis\Find"
rxfind Index-PNG.html /B:2 /SL /Q /P:"var NoFiles=[0-9]*" /R:"var NoFiles=%s%"
goto END

:JPG
IF NOT EXIST  Index-JPG.html ( copy "E:\Devel\Mis\Index-JPG.html" "%CD%\Index-JPG.html" )
set path=%path%;"E:\Devel\Mis\Find"
rxfind Index-JPG.html /B:2 /SL /Q /P:"var NoFiles=[0-9]*" /R:"var NoFiles=%s%"
goto END

:GIF
IF NOT EXIST  Index-GIF.html ( copy "E:\Devel\Mis\Index-GIF.html" "%CD%\Index-GIF.html" )
set path=%path%;"E:\Devel\Mis\Find"
rxfind Index-GIF.html /B:2 /SL /Q /P:"var NoFiles=[0-9]*" /R:"var NoFiles=%s%"
goto END

:END
::pause
endlocal