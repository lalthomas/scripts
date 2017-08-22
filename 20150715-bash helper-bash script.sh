# Author : Lal Thomas 
# Date : 2015-07-15
# © Lal Thomas (lal.thomas.mail@gmail.com)

# TODO: organize the routines

alias b=_bash_ # bash helper function


_bash_(){

	terminal(){
			
		command=$*			
		if [[ -z "${command// }" ]]; then
			cygstart mintty /bin/bash -il
		else
			/usr/bin/mintty.exe -i /Cygwin-Terminal.ico  /usr/bin/bash.exe -l -c "${command} && read -n1 -r -p \"Press any key to continue ...\" key;"
		fi
		
	}
	
	hist(){
		
		# Get option
		option=$1;	
		shift
		
		if [[ -z "$option" ]]; then
		   echo "error : few arguments"
		else
		   case "$option" in
				save)
					case "$OSTYPE" in
						darwin*)       
						filename="$rootPath/docs/$today-dev mac bash hist doc.txt"
						 ;; 
						cygwin*)
						filename="$rootPath/docs/$today-dev cygwin bash hist doc.txt"
						;;
						msys*)       
						filename="$rootPath/docs/$today-dev mingw bash hist doc.txt"
						;;  
						linux*)							
						filename="$rootPath/docs/$today-dev linux bash hist doc.txt"
						;;  							
					esac  						
					grep -v '^#' $HISTFILE > "$filename"
					;;										
				clear)
					hist -c
					hist -w
					echo "hist cleared..."
					;;		
				frequent)
					hist | awk '{print $2}' | awk 'BEGIN {FS="|"} {print $1}' | sort | uniq -c | sort -r
			esac
		fi		
		
	}
	
	# start markdown server
	start_markdown_server_one(){
		python "$rootpath/scripts/project/20150106-brainerd markdown server/brainerd.py"
	}

	# start markdown server
	start_markdown_server_two(){

		local serverRootPath=$2
		cd "$serverRootPath"    
		python "$rootpath/scripts/source/20140607-start simple http server with markdown support-python script.py"  
	
	}

	# find the text in folders
	search(){

		# thank you 
		# https://stackoverflow.com/questions/16956810/how-do-i-find-all-files-containing-specific-text-on-linux
		# https://stackoverflow.com/questions/26947813/append-string-on-grep-multiple-results-with-variable-in-a-single-command
		# https://stackoverflow.com/questions/6022384/bash-tool-to-get-nth-line-from-a-file
			
		OPTION=$1
		shift
				
		export B_SEARCH_TERM=""
		B_SEARCH_TERM="$@"
		
		# search all file recursively and find the matches and display it
		case "$OPTION" in
			text) grep --exclude-dir=".git*" -Rnw $PWD -e "${B_SEARCH_TERM}" |  awk '{printf "%s\t%s\n",++i,$0}' ;;		
			file) grep --exclude-dir=".git*" -Rnwl $PWD -e "${B_SEARCH_TERM}" |  awk '{printf "%s\t%s\n",++i,$0}' ;;
		esac
			
	}
	
	# open file from search result
	open(){
	
		IFS=","
		userinputs=($1)			
		unset IFS
						
		for i in ${userinputs[@]}
		do
			resultCount=$i
			cygstart "$(grep --exclude-dir=".git*" -Rnwl $PWD -e "${B_SEARCH_TERM}" | sed -n "${resultCount}p")"
		done
		
	}

	# search through all text files in current folder and move the matched lines to the filename
	replace_lines_in_txt_files_having_term(){
				
		term=$1
		shift
		filename=$*
		
		for file in *.txt 
		do
			 grep "$term" "$file">>"$filename"
			 # thanks http://stackoverflow.com/a/10467453/2182047
			 # sed escape before replace 
			 sed -i'' "/$(echo $term | sed -e 's/\([[\/.*]\|\]\)/\\&/g')/d" "$file"
		done
		sort "$filename" | uniq | sort -o "$filename"

	}

	# move the lines containing the term in all text file to a the filename	
	aggregate_lines_with_term(){

		# expects 
		# first argument - term ( e.g. +dev )
		# second argument - file name ( e.g. dev project.txt)
		
		 if [ -z $0 ];
		then 
			echo "TODO: no enough arguments"
			return
		fi

		term=$1		
		
		if [ $# -gt 1 ]; 
		then
			shift
			filename=$*
		else    
			#replace plus symbol
			fileNamePrefix=${term//+/}
			# replace backslash in variable
			fileNamePrefix=${fileNamePrefix//\// }
			filename="$today-$fileNamePrefix.txt"
		fi  
		
		replace_lines_in_txt_files_having_term $term $filename
		
	}

	
	_file_(){
				
		path(){
		
			init(){

				export B_FILE_FULL_PATH=""
				
				filepath="$@"
				B_FILEPATH="$(cygpath -u "${filepath}")"
				B_FILE_FULL_PATH=${B_FILEPATH}

				if [ "$(dirname "${B_FILEPATH}")" == "." ]
				then
					export B_FILE_FULL_PATH="$PWD/$(basename "${B_FILEPATH}")"
				fi
				
				# echo "file :${filepath}"
				# echo "file :${B_FILEPATH}"
				# echo "file :${B_FILE_FULL_PATH}"
				
			}
						
			OPTION=$1
			shift
			
			case $OPTION in				
				init) init "$@";;
			esac
					
		}
	
		total_number_of_lines(){
		
			lines=$(wc -l "$B_FILE_FULL_PATH")
			lines=${lines% ${B_FILE_FULL_PATH}}
			echo $lines
		}
								
		_search_(){
			
			# find the text in files
			# thank you 
			# https://stackoverflow.com/questions/16956810/how-do-i-find-all-files-containing-specific-text-on-linux
			# https://stackoverflow.com/questions/26947813/append-string-on-grep-multiple-results-with-variable-in-a-single-command
			# https://stackoverflow.com/questions/6022384/bash-tool-to-get-nth-line-from-a-file
				
			# set -x
			export B_FILE_SEARCH_TERM=""
			B_FILE_SEARCH_TERM="$@"			
			grep --exclude-dir=".git*" -i "$B_FILE_FULL_PATH" -e "${B_FILE_SEARCH_TERM}" |  awk '{printf "%d\t%s\n",++i,$0}'
			
			
		}
		
		result(){
					
			if [ $# -eq 0 ]
				then
				
				IFS=","
				userinputs=($B_FILE_PICK_LIST)
				unset IFS
						
				for i in ${userinputs[@]}
				do 								
					resultCount=$i			
					echo "$(grep --exclude-dir=".git*" -i "$B_FILE_FULL_PATH" -e "${B_FILE_SEARCH_TERM}" | sed -n "${resultCount}p")"
				done
				
			else	
			
				export B_FILE_PICK_LIST=""
				B_FILE_PICK_LIST="$@"
				
			fi
			
		}
		
		prompt(){
			
			# B_PICK_RESULT contains the user picked items
			message="$@"
			# initialize with invalid choice
			choice="$"
			until [[ $choice =~ ^[0-9|,]+$ ]] ; do
				read -p "$message" input
				echo				
				_search_ "$input"
				echo				
				read -p "enter comma separated value(s) [0 to end] : " choice
				# echo $CHOICE
				if [[ $choice =~ "0" ]]; then
					return
				fi
			done
			if [[ $choice =~ ^[0-9|,]+$ ]]; then
				result "$choice"
			fi
			
		}
		
		choose(){
				
			# initialize with invalid choice
			choice="$"		
			until [[ $choice =~ ^[0-9|,]+$ ]] ; do
				echo
				_search_ "$"
				echo
				read -p "enter comma separated value(s) [0 to end] : " choice
				# echo $CHOICE
				if [[ $choice =~ "0" ]]; then
					return
				fi				
			done			
			if [[ $choice =~ ^[0-9|,]+$ ]]; then
				result "$choice"
			fi
			
		}
		
		OPTION=$1
		shift
		
		case $OPTION in
			path ) path "$@";;
			prompt) prompt "$@";;
			result) result;;
			choose) choose;;
		esac
		
    }
		
	usage(){
	 
		echo "b <options>		"
		echo "					"
		echo "options			"
		echo "					"
		echo "hist clear	"
		echo "hist save		"
		echo "hist frequent	"
		echo "search text <term>"
		echo "search file <term>"
		echo "open <search result count>"
		echo "file path init <path>"
		echo "file search <query>"
		echo "file prompt <prompt message>"
		echo "file result"
		echo "file choose"

	}
	
	
	# Get action
	action=$1
	shift

	case $action in
	help|usage)usage;;
	hist) hist $@;;
	search) search $@;;
	open) open $@;;
	path) path $@;;
	terminal) terminal $@;;
	replace_lines_in_txt_files_having_term) replace_lines_in_txt_files_having_term $@;;
	aggregate_lines_with_term) aggregate_lines_with_term $@;;
	file) _file_ $@;;
	esac
		

}