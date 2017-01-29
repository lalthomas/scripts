# Filename : 20150715-git-bash script.sh 
# Author : Lal Thomas 
# Date : 2015-07-15
# © Lal Thomas (lal.thomas.mail@gmail.com)


### git 

alias g=_git_main_ # git helper functions

_git_main_(){
    
	usage(){
		
		echo "help"
		echo "===="
		echo 
		echo "g help"
		echo "g repo create <path>"
		echo "g repo commit <path> <message>"
		echo "g repo add gitignore"
	 
	}
	
	commitRepoChanges(){
	
		if [ $# -eq 1 ]; 
		then	
			commitMessage=$1
		else		
			commitMessage="commit changes"
		fi
				
		git add -A 
		git commit -m "$commitMessage"		
		
	}
	
	createRepo(){ 
	
		 git init
		 commitRepoChanges 'init repo' 
		 
	}
	
	gitignore() { 
		
		# thanks https://www.gitignore.io/docs		
		
		echo
		echo creating gitignore for $1 type...		
		echo 
		
		# 2017-01-29 not working now
		# curl -L -s "https://www.gitignore.io/api/$@" >>".gitignore"

		# refer readme file for the script to get the full listing
		curl -o .gitignore https://raw.githubusercontent.com/github/gitignore/master/$1.gitignore >/dev/null
		
	}

	# Get action
	action=$1
	shift

	# Get option
	option=$1
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
						createRepo						
						;;										
					commit)							
						message=$1
						commitRepoChanges $path $message						
						;;
					add)
						if [[ -z $2 ]]; then 
							"g error : few arguments"
						else
							option2=$1
							shift
							case "$option2" in
								gitignore)
								type=$1
								gitignore $type
							esac													
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
