@echo OFF
setlocal
set path=%PATH%;%~dp1
%~d1
cd %~p1
md "%~n1"
move %1 "%CD%\%~n1"
endlocal