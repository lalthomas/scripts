REM Author : Lal Thomas
REM Date   : 2019-10-26

REM Find directories with wallpapers
REM Display the list and ask for the option




set ViewerPath="E:\PortableApps.com\PortableApps\IrfanViewPortable\IrfanViewPortable.exe"

REM set dirs
REM dir /b /s wallpapers
set Directory="F:\box\2017\pictures\wallpapers\nature"

set ViewerOption="/closeslideshow /slideshow=%Directory%"

%ViewerPath% %ViewerOption%
