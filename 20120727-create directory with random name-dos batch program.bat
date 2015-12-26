#echo OFF
set path=%PATH%;%~dp1
%~d1
cd %~dp1
:: create temporary dir (which will be empty)
md tempdir
:: tell DOS to put temp files there (saving old %temp%)
set org_temp=%temp%
set temp=tempdir
:: now pipe a CR to copy. This will create a non-zero length
:: file with no extension (*.) which will be copied as *.rnd
echo. | copy %temp%\*. %temp%\*.rnd
:: DOS will delete its temp files (*.) but _not_ the copies.
:: Change to the temp dir so that FOR command will not include
:: the directory in its variable
cd %temp%
:: remove the extension
ren *.rnd *.
:: now set a variable to the filename
for %%r in (*.) do set random=%%r
:: back to the original directory, delete the temp dir and
:: restore %temp%
cd ..
del %temp%\*.rnd
rd %temp%
set temp=%org_temp%
:: And show the results
echo %random%
:: Create a directory, and change to it
md %random%
cd %random%
