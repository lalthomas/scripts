# Author : Lal Thomas 
# Date : 2015-07-15
# © Lal Thomas (lal.thomas.mail@gmail.com)

alias b=_bash_ # bash helper function

usage(){
 
 echo help
 echo history clear
 echo history save

}

_bash_(){

	# Get action
	action=$1
	shift

	# Get option
	option=$1;	
	shift

	re="^(help|history)$"
	
	if [[ "$action"=~$re ]]; then	
		case $action in
		'help')
			usage
			;;
		'history')        
			if [[ -z "$option" ]]; then
			   echo "g error : few arguments"			   
			else			  	
			   case "$option" in
					save)
						filePath=
						grep -v '^#' $HISTFILE > "$rootPath/docs/$today-dev bash history.txt"
						;;										
					clear)
						history -c
						;;						
				esac
			fi				
			;;
		esac
	else
		echo "g error: unrecognised option \"$option\"."
		echo "try \" b help\" to get more information."	
	fi	

}