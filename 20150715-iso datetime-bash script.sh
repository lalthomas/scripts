# Filename : 20150715-iso datetime-bash script.sh
# Author : Lal Thomas 
# Date : 2015-07-15
# © Lal Thomas (lal.thomas.mail@gmail.com)

alias today=$(date "+%Y%m%d")
alias longdate=$(date "+%Y-%m-%d")
alias weekCount=$(date +'%V')
alias dayOfWeeK=$(date +%A)
alias monthCount=$(date +'%m')
alias yearCount=$(date +'%Y')
alias dayOfWeekLowerCase=$(date +%A | sed -e 's/\(.*\)/\L\1/')
case "$OSTYPE" in
	darwin*) 
	# OSX	
	alias yesterday=$(date -v-1d "+%Y%m%d")
	alias longyesterday=$(date -v-1d "+%Y-%m-%d")	
	alias dayofWeekYesterday=$(date -v-1d +%A)
	;; 
	msys*) 
	# Windows	
	alias yesterday=$(date --date='yesterday' +'%Y%m%d')
	alias longyesterday=$(date --date='yesterday' +'%Y-%m-%d')
	alias dayofWeekYesterday=$(date --date='yesterday' +%A)
	;;	
	
	cygwin*) 
	# Windows	
	alias yesterday=$(date --date='yesterday' +'%Y%m%d')
	alias longyesterday=$(date --date='yesterday' +'%Y-%m-%d')
	alias dayofWeekYesterday=$(date --date='yesterday' +%A)
	;;	
	
	*) 
	echo "unknown: $OSTYPE" ;;
esac