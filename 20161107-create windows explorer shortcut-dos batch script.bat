@echo OFF
REM Lal Thomas
REM 2016-11-07


REM Script (test.bat) to create a shortcut to itself 
REM thanks http://stackoverflow.com/a/30029955/2182047

powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%~n0.lnk');$s.TargetPath='%~f0';$s.Save()"
