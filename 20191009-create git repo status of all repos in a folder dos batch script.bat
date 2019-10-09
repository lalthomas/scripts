@echo ON

setlocal

for /f "tokens=*" %%f in ('dir /a:D /s /b') do  (

	set gs= 
	call :gitstatus %%f
	echo "%%f",%gs% >"git status.csv"
)

endlocal

:gitstatus
pushd %%f
for /f "tokens=*" %%g in ('git status') do ( set gs=%gs% %g% )
popd
exit /b 0

