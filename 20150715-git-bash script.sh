# Filename : 20150715-git-bash script.sh 
# Author : Lal Thomas 
# Date : 2015-07-15
# © Lal Thomas (lal.thomas.mail@gmail.com)


### git 

alias g=_git_main_ # git helper functions

createRepo(){ 

 git init "$1"
 commitRepoChanges "$1" 'init repo' 
 
}

commitRepoChanges(){
	
	if [ $# -eq 2 ]; 
	then	
		commitMessage=$2		
	else		
		commitMessage="commit changes"
	fi
	
	cd "$1"	
	git add -A 
	git commit -m "$commitMessage"
	echo $1 "folder changes committed" 
	
}


# thanks https://www.gitignore.io/docs
# run creategitignore xcode >.gitignore

creategitignore() { 

curl -L -s "https://www.gitignore.io/api/$@"

}

alias creategitignore=creategitignore


usage(){
 
 echo "help"
 echo "===="
 echo 
 echo "g help"
 echo "g repo create <path>"
 echo "g repo commit <path> <message>"
 
}

_git_main_(){
    
	# Get action
	action=$1
	shift

	# Get option
	option=$1;	
	shift

	
	re="^(help|repo)$"
	
	if [[ "$action"=~$re ]]; then
		case $action in
		'help')
			usage
			;;
		'repo')        
			if [[ -z "$option" ]]; then
			   echo "g error : few arguments"			   
			else			  	
			   case "$option" in
					create)
						if [[ -z $1 ]]; then 
							"g error : few arguments"
						else	
							path=$@
							createRepo $path						
						fi
						;;										
					commit)
						if [[ -z $2 ]]; then 
							"g error : few arguments"
						else	
							path=$1
							message=$2
							commitRepoChanges $path $message
						fi
						;;						
				esac
			fi				
			;;
		esac
	else
		echo "g error: unrecognised option \"$option\"."
		echo "try \" view help\" to get more information."
	fi
	
}
