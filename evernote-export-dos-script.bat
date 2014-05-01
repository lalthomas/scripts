@echo OFF
set notebook=20120423-dev
set path=E:\Devel\Mis
call MarkdownifyBatch.bat "%CD%"
SET /p _tag=Enter tag :
ren *.md *.txt
ren *.txt *.#%_tag%.txt
move *.txt ..\%notebook%
del *.html