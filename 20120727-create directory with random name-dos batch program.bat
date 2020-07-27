REM echo OFF
setlocal
set path=%PATH%;%~dp1
%~d1
cd %~dp1
set rad=%random%
md %rad%
cd %rad%
endlocal