@echo OFF
set /p year="enter year:"
pushd .
md %year%
cd %year%
md "docs"
md "media"
popd