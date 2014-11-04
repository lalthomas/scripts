@echo OFF
setlocal
set path=%PATH%;E:\Devel\Mis\Html2text
del E:\Temp\ARCH.txt
copy %1 "E:\Temp\Arch.htm"
call HTML2TXT E:\Temp\Arch.htm @HTML2TXT.INI -AB-I-h--o:A 
copy "E:\Temp\ARCH.txt" "%~d1%~p1%~n1.txt"
REM ::pause
REM goto end
REM :end
endlocal
REM pause