#echo OFF
setlocal
set path=%PATH%;%~dp1
%~d1
cd %~dp1
md %random%
cd %random%
endlocal