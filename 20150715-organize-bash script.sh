# Filename : 20150715-organize-bash script.sh
# Author : Lal Thomas 
# Date : 2015-07-15
# © Lal Thomas (lal.thomas.mail@gmail.com)

# file maniapulation functions

convertAllFilenamesToLower(){
	cd "$1"
	for f in *; do mv "$f" "`echo $f | tr "[:upper:]" "[:lower:]"`"; done
}

alias renamedocs="convertAllFilenamesToLower '$rootpath/docs'"