# Filename : 20150715-git-bash script.sh 
# Author : Lal Thomas 
# Date : 2015-07-15
# © Lal Thomas (lal.thomas.mail@gmail.com)


### git 

alias gh=_git_main_ # git helper functions

_git_main_(){
    
	
	_stage_(){
		
		OPTION=$1
		shift

		case $OPTION in
			file) git add "$@" > /dev/null 2>&1 ;;
			all) git add -A > /dev/null 2>&1 ;;
		esac
		
	}
	
	_commit_(){
		
		if [ $# -gt 0 ]; 
		then	
			commitMessage=$@
		else		
			commitMessage="commit changes"
		fi
		
		# committing background
		(nohup git commit -m "$commitMessage" >/dev/null &>/dev/null 2>&1 &)
		
	}
	
	_create_(){ 
	
		 git init > /dev/null 2>&1
		 _stage_ all
		 _commit_ 'init repo'
		 
	}
	
	gitignore() { 
			
		if [ $# -eq 1 ]; 
		then				
			language=$@
		else	

			# pick the language
			b file linepicker init "D:\do\reference\20171025-programming language list script support.txt"
			echo 
			b file linepicker prompt "enter keyword for language : "
			language="$(b file linepicker result)"			

		fi
		
		# thanks https://www.gitignore.io/docs		
		echo creating gitignore for $language type...		
		# 2017-01-29 not working now
		# curl -L -s "https://www.gitignore.io/api/$@" >>".gitignore"
		# refer readme file for the script to get the full listing
		curl --silent -o .gitignore https://raw.githubusercontent.com/github/gitignore/master/$language.gitignore >/dev/null
		
		_stage_ file .gitignore
		_commit_ "add gitignore"
		
	}
	
	detect(){
	
		# thanks : https://stackoverflow.com/a/25149786/2182047
				
		if [[ `git status --porcelain` ]]; then
			echo "changes present"
		else			
			echo "no change"
		fi
		
	}

	usage(){
		
		echo 
		echo "Usage"
		echo "====="
		echo 
		echo "gh OPTIONS"
		echo 
		echo "where OPTIONS are"
		echo " - help"
		echo " - repo create"
		echo " - repo stage all"
		echo " - repo stage file <path>"
		echo " - repo commit <message>"	
		echo " - repo add gitignore <type>"
		echo " - detect"
	 
	}
	
	# Get action
	action=$1
	shift

	# Get option
	option=$1
	shift
	
	re="^(help|detect|repo)$"
	
	if [[ "$action"=~$re ]]; then
		case $action in
		'help')
			usage
			;;		
		'detect')
			detect
			;;
		'repo')        
			if [[ -z "$option" ]]; then
			   echo "g error : few arguments"
			else			  	
			   case "$option" in
					create)
						_create_
						;;
					commit)
						_commit_ $@
						;;
					stage)
						_stage_ $@
						;;
					add)
						option2=$1
						shift
						case "$option2" in
							gitignore)
								type=$1
								gitignore $type
							;;
						esac						
						;;
				esac
			fi
			;;
		esac
	else
		echo "gh error: unrecognised option \"$option\"."
		echo "try \" view help\" to get more information."
	fi
	
}
