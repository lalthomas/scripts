@echo OFF

setlocal
:LOOP_FILE_ONE
if [%1] NEQ [] (
  echo %1
) ELSE ( 
  goto LOOP_FILE_ONE_EXIT 
)
SHIFT
GOTO LOOP_FILE_ONE
:LOOP_FILE_ONE_EXIT 
pause
endlocal

