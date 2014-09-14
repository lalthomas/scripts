@echo OFF
:cleanH
cd \
H:
goto EndFile

:EndFile

del /arh *.exe
del /arh *.bat
del /arh *.vbs
del /arh *.cmd
del /arh autorun.inf
del /ah autorun.inf
del  autorun.inf
cls
echo Hidden Files
echo ***********************
dir /ah
echo Exectuables
echo ***********************
dir *.exe
pause
cls
echo  Hidden Inner Directory Files
echo ***********************
dir /s/ah/p
pause
cls
echo Present Files
echo ***********************
dir
pause
cls
