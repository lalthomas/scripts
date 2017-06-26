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
						case "$OSTYPE" in
							darwin*)       
							filename="$rootPath/docs/$today-dev mac bash history doc.txt"
							 ;; 
							cygwin*)
							filename="$rootPath/docs/$today-dev cygwin bash history doc.txt"
							;;
							msys*)       
							filename="$rootPath/docs/$today-dev mingw bash history doc.txt"
							;;  
							linux*)							
							filename="$rootPath/docs/$today-dev linux bash history doc.txt"
							;;  							
						esac  						
						grep -v '^#' $HISTFILE > "$filename"
						;;										
					clear)
						history -c
						history -w
						echo "history cleared..."
						;;		
					frequent)
						history | awk '{print $2}' | awk 'BEGIN {FS="|"} {print $1}' | sort | uniq -c | sort -r
				esac
			fi				
			;;
		esac
	else
		echo "g error: unrecognised option \"$option\"."
		echo "try \" b help\" to get more information."	
	fi	

}