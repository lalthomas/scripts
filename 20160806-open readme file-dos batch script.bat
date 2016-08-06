@echo OFF
setlocal
REM The following two line are Npp Hack for not changing the current path
%~d1
cd %~p1
start explorer "%~n1 readme.md"
endlocal
exit