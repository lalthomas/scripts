@echo OFF

setlocal

for /f "tokens=*" %%f in ('dir /a:D /b *') do  (

	set gs= 
	echo "%%~dpnxf"
	call :gitstatus %%~dpnxf
	REM echo "%%f","%gs%" >>"git status.csv"
)

endlocal
pause

exit /b 0


:gitstatus
pushd %*
( git status )
REM for /f %%g in ('git status') do ( set gs=%gs% %g% )
REM echo %gs%
popd
exit /b 0

