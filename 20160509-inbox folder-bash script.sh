#!/bin/bash -x

# Filename : 20160509-inbox folder-bash script.sh
# Author : Lal Thomas 
# Date : 2016-05-09
# © Lal Thomas (lal.thomas.mail@gmail.com)

# initialize global variables 
currentScriptFolder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

alias inbox=_inbox_

_inbox_(){	

	
	string_replace_underscore_with_space(){
	
		echo $1 | sed 's/_/ /g'
		
	}
	
	string_replace_dash_with_space(){
	
		echo $1 | sed 's/-/ /g'
		
	}
	
	string_replace_dot_with_space(){
	
		echo $1 | sed 's/\./ /g'
		
	}
	
	string_unify_multiple_spaces(){
	
		echo $1 | sed 's/ +/ /g'
		
	}
	
	string_unify_multiple_dash(){
	
		echo $1 | sed 's/--/-/g'
		
	}
	
	string_convert_to_lower(){
	
		# convert to lowercase
		echo $1 | tr "[:upper:]" "[:lower:]"
		
	}
			
	string_get_file_name(){
	
		filename=$(basename "$1")
		echo "${filename%.*}"
		
	}
	
	string_get_file_extension(){
	
		filename=$(basename "$1")
		echo "${filename##*.}"
	}
		
	string_trim_whitespace(){
	
		name=$1
		shopt -s extglob 	 # turn it on
		name="${name##*( )}" # Trim leading whitespaces
		name="${name%%*( )}" # trim trailing whitespaces		
		shopt -u extglob  	 # turn it off
		echo $name
		
	}

	file_get_created_datetime(){
	
		date_created=$(stat --format "%W" "$1")
		echo $(date --date="@$date_created" +%Y%m%d-%H%M)
		
	}

	file_get_created_date(){
	
		date_created=$(stat --format "%W" "$1")
		echo $(date --date="@$date_created" +%Y%m%d)
		
	}

	
	clean_course_folder(){	
		
		# change the folder				
		# i tried a lot of way to get 
		# it via a variable,bash simply won't allow that
		# so direct push
		
			
		# pushd "D:\Inbox\course" > /dev/null 2>&1
		pushd "W:\Inbox\course" > /dev/null 2>&1
		# pushd "X:\Inbox\course" > /dev/null 2>&1
		# pushd "Y:\Inbox\course" > /dev/null 2>&1
		# pushd "Z:\Inbox\film" > /dev/null 2>&1		
		
		# read only directories
		for d in */ ; do
			
			pushd $PWD  > /dev/null 2>&1
			
			# ----------------
			# rename files
			# ----------------
			
			# change directory
			cd "$d"			
			echo "$d"			
			# loop through files
			for f in *; do			
				
				# skip directories
				if [[ -d $f ]]; then continue; fi 
				# skip ini files
				if [[ $f == *.ini ]]; then continue; fi 

										
				filename=$(string_get_file_name "$f")
				extension=$(string_get_file_extension "$f")	
				createdate=$(file_get_created_date "$f")
				
				# remove folder name
				folder=${d%/}				
				newname=${filename#${folder}}
				# end of remove folder name
				
				newname=$(string_replace_underscore_with_space "$newname")				
				newname=$(string_replace_dash_with_space "$newname")				
				newname=$(string_replace_dot_with_space "$newname")
				newname=$(string_unify_multiple_spaces "$newname")
				newname=$(string_unify_multiple_dash "$newname")																																	
				
				newfilename=$(string_trim_whitespace "$newname")
				newextension=$(string_trim_whitespace "$extension")
							
				newname="$(echo $folder - $newfilename.$newextension)"
				newname=$(string_convert_to_lower "$newname")
				
				echo "	$f : $newname"
				# add a log file
				echo "$f" >>"$newname.log"				
				# rename file
				mv "$f" "$newname";						

			done
			
			# continue	
			
			# exit from folder
			cd ..
		
			# --------------------
			# end of rename files
			# --------------------			
			
			
			# --------------------
			# move files and index
			# --------------------
						
			# move and  rename folder 			
			folderdate=$(file_get_created_date "$d")
			newfolder="$(echo $folderdate-$d)"									
			mv -i "$d" "../../courses/$newfolder"		

			# list the files in moved folder
			cd "../../courses/$newfolder"								
			for f in *; do
									
				p=$(readlink -f "$f")				
				winp=$(cygpath -w "$p")
				echo "$winp" >>"files.txt"
								
			done

			# move the filelist to upper folder
			mv "files.txt" "../${newfolder%/}.txt"	
			
			# ---------------------------
			# end of move files and index
			# ---------------------------
			
			
			popd  > /dev/null 2>&1
						
		done
								
		# remove from stack
		popd > /dev/null 2>&1
			
	}
	
	clean_doc_folder(){
				
		clean_mail_chumma(){
			
				pushd "D:\Inbox\doc\cleanup thunderbird\chumma" > /dev/null 2>&1
			
				for f in *; do
					if [[ -d $f ]]; then continue; fi # skip directories	
					newname="$(echo $f | sed 's/_/ /g')" # substitute underscore with space
					newname="$(echo $newname | sed 's/\[[0-9] Attachment\]//g')" 			
					newname="$(echo $newname | sed 's/--/-/g')" # substitute double dash with single dash
					newname="$(echo $newname | sed 's/ +/ /g')" # remove multiple spaces into one
					newname="$(echo $newname | sed 's/-[0-9][0-9]-[a-z]*-[0-9][0-9][0-9][0-9]//g')"
					newname="$(echo $newname | sed 's/Chumma ) //g')"			
					newname="$(echo $newname | sed 's/[0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]//g')"			
					newname="$(echo $newname | sed 's/([0-9][0-9]-[0-9][0-9].-[0-9][0-9][0-9][0-9])//g')"	
					newname="$(echo $newname | sed 's/([0-9][0-9]_[0-9][0-9]_[0-9][0-9][0-9][0-9])//g')" 			
					newname="$(echo $newname | sed 's/([a-z][a-z][a-z])-([0-9][0-9])-([0-9][0-9][0-9][0-9])\s\(([a-z]*)\)//g')" 			
					newname="$(echo $newname | sed 's/(\s*)$//g')" 			
					newname="$(echo $newname | sed 's/-/ /g')" # substitute dash with space
					newname="$(echo $newname | sed 's/\([0-9]\{8\}\) /\1-/g')" # append date string with dash			
					newname="$(echo $newname | tr "[:upper:]" "[:lower:]")" # convert to lowercase			
					
					# thanks http://stackoverflow.com/a/965072/2182047
					filename=$(basename "$newname")
					extension="${filename##*.}" # extract extension
					name="${filename%.*}" #extract name
					
					# trim whitespaces
					# thanks : http://www.cyberciti.biz/faq/bash-remove-whitespace-from-string/
					shopt -s extglob 	 # turn it on
					name="${name##*( )}" # Trim leading whitespaces
					name="${name%%*( )}" # trim trailing whitespaces
					shopt -u extglob  	 # turn it off
					# end of trim
					
					newname="$(echo $name.$extension)" # join
								
					echo $f : $newname
					mv "$f" "$newname"; # rename the files
				done
					
				popd
			}
		
		clean_doc_docs_names(){
		
				pushd "D:\Inbox\doc\import folder doc" > /dev/null 2>&1
		 
				mkdir "clean-named" &>/dev/null
				ls | grep -e"[0-9]\{8\}" | xargs -d"\n" mv -t "$PWD/clean-named" &>/dev/null		
				echo "Files with clean name moved ..."
				echo "Processing remaining files ..."
				echo .
				shopt -u nullglob
				shopt -u dotglob
				for f in *; do 
					if [[ -d $f ]]; then continue; fi # skip directories
					if [[ $f == *.ini ]]; then continue; fi # skip ini files
					date_created=$(stat --format "%W" "$f")
					date_created_format=$(date --date="@$date_created" +%Y%m%d-%H%M)
					newname="$(echo $f | tr "[:upper:]" "[:lower:]")" # convert to lowercase			
					newname="$(echo $newname | sed 's/-/ /g')" # substitute dash with space
					newname="$(echo $newname | sed 's/_/ /g')" # substitute underscore with space
					newname="$(echo $newname | sed 's/ +/ /g')" # remove multiple spaces into one
					newname="$date_created_format-$newname" # prepend created date			
					echo $f : $newname
					mv "$f" "$newname"; # rename the files
				done	
				# delete empty folders
				find . -empty -type d -delete
				
				popd
			}

		clean_doc_calibre_periodical(){
			
			pushd "D:\Inbox\doc\cleanup thunderbird\newstoday" > /dev/null 2>&1
			
			for f in *; do
					if [[ -d $f ]]; then continue; fi # skip directories	
					newname="$(echo $f | sed 's/_/ /g')" # substitute underscore with space
					newname="$(echo $newname | sed 's/\[[0-9] Attachment//g')" 
					newname="$(echo $newname | sed 's/NewsToday\]\s*//g')" 			
					newname="$(echo $newname | sed 's/--/-/g')" # substitute underscore with space						
					newname="$(echo $newname | sed 's/ +/ /g')" # remove multiple spaces into one
					newname="$(echo $newname | sed 's/-[0-9][0-9]-[a-z]*-[0-9][0-9][0-9][0-9]//g')"
					newname="$(echo $newname | sed 's/sMathrubhumi\ /Mathrubhumi/g')"
					newname="$(echo $newname | sed 's/FWD-//g')"
					newname="$(echo $newname | sed 's/[0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]//g')"			
					newname="$(echo $newname | sed 's/([0-9][0-9]-[0-9][0-9].-[0-9][0-9][0-9][0-9])//g')"	
					newname="$(echo $newname | sed 's/([0-9][0-9]_[0-9][0-9]_[0-9][0-9][0-9][0-9])//g')" 			
					newname="$(echo $newname | sed 's/([a-z][a-z][a-z])-([0-9][0-9])-([0-9][0-9][0-9][0-9])\s\(([a-z]*)\)//g')" 			
					newname="$(echo $newname | sed 's/(\s*)$//g')" 			
					newname="$(echo $newname | sed 's/sDeshabhimani/Deshabhimani/g')" 			
					newname="$(echo $newname | sed 's/MB/Mathrubhumi/g')"
					newname="$(echo $newname | sed 's/RD/Rashtra Deepika/g')"
					newname="$(echo $newname | sed 's/KK F/Kerala Kaumudi Flash/g')"
					newname="$(echo $newname | sed 's/KK/Kerala Kaumudi/g')"
					newname="$(echo $newname | sed 's/-/ /g')" # substitute dash with space
					newname="$(echo $newname | sed 's/\([0-9]\{8\}\) /\1-/g')" # append date string with dash			
					newname="$(echo $newname | tr "[:upper:]" "[:lower:]")" # convert to lowercase			
					
					# thanks http://stackoverflow.com/a/965072/2182047
					filename=$(basename "$newname")
					extension="${filename##*.}" # extract extension
					name="${filename%.*}" #extract name
					
					# trim whitespaces
					# thanks : http://www.cyberciti.biz/faq/bash-remove-whitespace-from-string/
					shopt -s extglob 	 # turn it on
					name="${name##*( )}" # Trim leading whitespaces
					name="${name%%*( )}" # trim trailing whitespaces
					shopt -u extglob  	 # turn it off
					# end of trim
					
					newname="$(echo $name.$extension)" # join
								
					echo $f : $newname
					# rename the files
					mv "$f" "$newname";
				done
				
			popd
			
			}
	
		clean_mail_chumma
		clean_doc_docs_names
		clean_doc_calibre_periodical
		
	}
	
	clean_feeds_folder(){
	
		echo
		
	}
		
	clean_film_folder(){
	
		# change the folder				
		# i tried a lot of way to get 
		# it via a variable,bash simply won't allow that
		# so direct push
		
		pushd "D:\Inbox\film" > /dev/null 2>&1
		# pushd "W:\Inbox\film" > /dev/null 2>&1
		# pushd "Y:\Inbox\film" > /dev/null 2>&1
		
		
		# read only directories
		for d in */ ; do
			
			# change directory
			cd "$d"			
			echo "$d"
			# loop through files
			for f in *; do			
				
				# skip directories
				if [[ -d $f ]]; then continue; fi 
				# skip ini files
				if [[ $f == *.ini ]]; then continue; fi 

				# createdate=$(file_get_created_date "$f")
			
				# strip revalent details after year
				newname="$(echo $f | sed 's/\(.*\)\([0-9]\{4\}\)\(.*\)/\1\(\2\)/g')"
								
				# newname=$(string_convert_to_lower "$newname")
				newname=$(string_replace_underscore_with_space "$newname")
				newname=$(string_replace_dot_with_space "$newname")
				newname=$(string_unify_multiple_spaces "$newname")
				newname=$(string_unify_multiple_dash "$newname")
							
				filename=$(string_get_file_name "$newname")
				extension=$(string_get_file_extension "$f")
				folder=${d%/}				
																				
				newfilename=$(string_trim_whitespace "$filename")
				newextension=$(string_trim_whitespace "$extension")
							
				newname="$(echo $newfilename $folder.$newextension)"
										
				echo "	$f : $newname"
				# add a log file
				echo "$f" >>"$newname.log"
				mv "$f" "$newname";
				
			done
			
			cd ..						
		done
		
		# remove from stack
		popd > /dev/null 2>&1
	}
	
	clean_help_folder(){
	
		echo
	}
	
	clean_lab_folder(){
	
		echo
	}
	
	clean_music_folder(){
	
		echo
	}
	
	clean_notes_folder(){
	
		echo
	}
	
	clean_picture_folder(){
	
		echo
		
	}
	
	clean_resource_folder(){
	
		echo
	}
		
	clean_sound_folder(){
		
		echo
		
	}
		
	clean_tool_folder(){
	
		echo
	
	}
	
	clean_video_folder(){
	
		echo
	}
		
	
	usage(){

        echo 
        echo "Inbox OPTIONS"      
        echo " helper script to managing inbox folder"   
		echo " clean_doc_calibre_periodical"
		echo " clean_mail_chumma"
        echo " clean_doc_docs_names"	
		echo " clean_film_folder"
	}
			
	ACTION=$1
	shift	
	
	case "$ACTION" in		
		help|usage)	usage ;;
		clean_doc_calibre_periodical) clean_doc_calibre_periodical;;		
		clean_doc_docs_names) clean_doc_docs_names;;
		clean_mail_chumma) clean_mail_chumma;;
		clean_film_folder) clean_film_folder;;
		clean_course_folder) clean_course_folder;;
	esac
	
}