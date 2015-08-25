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
export currentMonthFirstMonday=$(d=$(date -d `date +%Y%m"01"` +%u);date -d `date +%Y-%m-"0"$(((9-$d)%7))` '+%Y-%m-%d') # cygwin, git-bash 
export currentMonthSecondMonday=$(date -d "$currentMonthFirstMonday 7 days" '+%Y-%m-%d')
export currentMonthThirdMonday=$(date -d "$currentMonthFirstMonday 14 days" '+%Y-%m-%d')
export currentMonthFourthMonday=$(date -d "$currentMonthFirstMonday 21 days" '+%Y-%m-%d')
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
