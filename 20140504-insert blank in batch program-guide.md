@echo ON
echo "Start..."

REM Variable to insert blank line
REM Two empty lines are necessary
REM echo Line1!LF!Line2
REM Thanks to http://stackoverflow.com/a/6379940
setlocal EnableDelayedExpansion
set LF=^


for /r %%i in (*.txt) do echo !LF!!LF!======== >> %%i