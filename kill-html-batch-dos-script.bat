@echo OFF
setlocal
set path=%PATH%;E:\Devel\Mis\Html2text
echo Beautify CSS Options
echo .....................................................
echo 1. Single File
echo 2. Multiple Files
echo .....................................................
SET /p _Opt=Enter your choice : 
@echo OFF
SET SingleFileFlag= "1"
IF /I "%_Opt%" == "1" ( SET SingleFileFlag=1)
IF /I "%_Opt%" == "2" ( SET SingleFileFlag=0)
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Registry
::cmd /k cd %CD% | set path=%PATH%;E:\Devel\Mis\Html2text | for %%f in (*.html) do ( copy %%f E:\Temp\Arch.htm | del E:\Temp\ARCH.txt | call E:\Devel\Mis\Html2text\HTML2TXT E:\Temp\Arch.htm @HTML2TXT.INI -AB-I-h--o:A | copy "E:\Temp\ARCH.txt" "%%f%.txt" )
for %%f in (*.html) do ( 
copy %%f E:\Temp\Arch.htm
del E:\Temp\ARCH.txt 
start /wait "HTM2TEXT" E:\Devel\Mis\Html2text\HTML2TXT E:\Temp\Arch.htm @HTML2TXT.INI -AB-I-h--o:A 
IF /I "%SingleFileFlag%" == "1" ( type "E:\Temp\ARCH.txt" >>"Combined.txt" )
IF /I "%SingleFileFlag%" == "0" ( type "E:\Temp\ARCH.txt" >%%f.txt )
)
::pause
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::