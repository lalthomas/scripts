setlocal
@echo OFF
set /a s=1
:CheckPoint
if EXIST "Capture-%s%%~x1" (set /a s=s+1) ELSE (goto RENAM)
goto CheckPoint
:RENAM
REN %1 "Capture-%s%%~x1"
:END