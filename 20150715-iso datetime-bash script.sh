# Filename : 20150715-iso datetime-bash script.sh
# Author : Lal Thomas 
# Date : 2015-07-15
# © Lal Thomas (lal.thomas.mail@gmail.com)

export today=$(date "+%Y%m%d")
export longdate=$(date "+%Y-%m-%d")
export weekCount=$(date +'%V')
export dayOfWeeK=$(date +%A)
export monthCount=$(date +'%m')
export yearCount=$(date +'%Y')
export dayOfWeekLowerCase=$(date +%A | sed -e 's/\(.*\)/\L\1/')
case "$OSTYPE" in
	darwin*) 
	# OSX	
	export yesterday=$(date -v-1d "+%Y%m%d")
	export longyesterday=$(date -v-1d "+%Y-%m-%d")	
	export dayofWeekYesterday=$(date -v-1d +%A)
	;; 
	msys*) 
	# Windows	
	export yesterday=$(date --date='yesterday' +'%Y%m%d')
	export longyesterday=$(date --date='yesterday' +'%Y-%m-%d')
	export dayofWeekYesterday=$(date --date='yesterday' +%A)
	;;	
	
	cygwin*) 
	# Windows	
	export yesterday=$(date --date='yesterday' +'%Y%m%d')
	export longyesterday=$(date --date='yesterday' +'%Y-%m-%d')
	export dayofWeekYesterday=$(date --date='yesterday' +%A)
	;;	
	
	*) 
	echo "unknown: $OSTYPE" ;;
esac