@echo OFF
REM Author : Lal Thomas
REM Date : 2019-11-29
start C:\cygwin64\bin\mintty.exe -h always -s 150,36 -p center -e /usr/bin/bash -login -i -c "t lsp C"
start C:\cygwin64\bin\mintty.exe -h always -s 150,36 -p center -e /usr/bin/bash -login -i -c "t lsp B"
start C:\cygwin64\bin\mintty.exe -h always -s 150,36 -p center -e /usr/bin/bash -login -i -c "t lsp A"
start C:\cygwin64\bin\mintty.exe -p right /bin/bash -il
