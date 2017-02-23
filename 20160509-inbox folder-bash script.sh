#!/bin/bash -x

# Filename : 20160509-inbox folder-bash script.sh
# Author : Lal Thomas 
# Date : 2016-05-09
# © Lal Thomas (lal.thomas.mail@gmail.com)

alias inbox=_inbox_

_inbox_(){	

	# generic routines
	
	string_replace_underscore_with_space(){
	
		echo $1 | sed 's/_/ /g'
		
	}
	
	string_replace_brackets_with_space(){
		
		echo $1 | sed 's/[({})]/ /g' | sed -r 's/(\[|\])/ /g'		
		
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
	
	string_replace_url(){
			
		echo $1 | sed 's/www.[^ ]*//g'
		
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

	# folder routines
	
	clean_course_folder(){	
		
		# change the folder				
		# i tried a lot of way to get 
		# it via a variable,bash simply won't allow that
		# so direct push
		
		change_drive(){
		
			# change the folder				
			# i tried a lot of way to get 
			# it via a variable,bash simply won't allow that
			# so direct push
			echo "drive : $1"
			case $1 in
				d|D) pushd "D:\Inbox\courses" > /dev/null 2>&1;;
				w|W) pushd "W:\Inbox\courses" > /dev/null 2>&1;;		
				x|X) pushd "X:\Inbox\courses" > /dev/null 2>&1;;		
				y|Y) pushd "Y:\Inbox\courses" > /dev/null 2>&1;;
				z|Z) pushd "Z:\Inbox\courses" > /dev/null 2>&1;;
				*) 
					echo "unknown drive"; 
					return;
				;;
			esac	
			return
		}			
		
		rename_files(){
			
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
					echo "$newname : $f" >>"log.txt"				
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
											
				# get the date of the directory
				folderdate=$(file_get_created_date "$d")
				# path simplied	
				newfolder="$(echo $folderdate-$d)"													
				mv -i "$d" "../../courses/$newfolder"		

				# list the files in moved folder
				cd "../../courses/$newfolder"								
				
				for f in *; do
										
					p=$(readlink -f "$f")				
					winp=$(cygpath -w "$p")
					echo "$winp" >>"files.txt"
									
				done
												
				# get the drive and path and escape the path
				fp=$(echo $(cygpath -w "../../courses") | xargs echo | sed 's\:\-\g' )				
				playlistname="$(echo $folderdate-$fp-$d | tr '[:upper:]' '[:lower:]')"
				
				# move the filelist to upper folder	
				# mv "files.txt" "../${playlistname%/}.m3u"
				
				# move the filelist to reference
				refpath=$(cygpath -u "D:\Dropbox\do\reference")
				mv "files.txt" "$refpath/${playlistname%/}.m3u"
				echo "${playlistname%/}.m3u" >> "$refpath/readme.md"
				
				
				# ---------------------------
				# end of move files and index
				# ---------------------------
				
				
				popd  > /dev/null 2>&1
							
			done								
										
		}
		
		change_drive $1
		rename_files
		
		# remove from stack
		popd > /dev/null 2>&1
	}
	
	clean_doc_folder(){


		change_drive(){
		
			# change the folder				
			# i tried a lot of way to get 
			# it via a variable,bash simply won't allow that
			# so direct push
			echo "drive : $1"
			case $1 in
				d|D) pushd "D:\Inbox\doc" > /dev/null 2>&1;;
				w|W) pushd "W:\Inbox\doc" > /dev/null 2>&1;;		
				x|X) pushd "X:\Inbox\doc" > /dev/null 2>&1;;		
				y|Y) pushd "Y:\Inbox\doc" > /dev/null 2>&1;;
				z|Z) pushd "Z:\Inbox\doc" > /dev/null 2>&1;;
				*) 
					echo "unknown drive"; 
					return;
				;;
			esac	
			return
		}
		
		clean_cleanup_thunderbird_folder(){
		
			clean_doc_cleanup_thunderbird_newstoday_folder(){
			
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
	
			clean_doc_cleanup_thunderbird_chumma_folder(){
					
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
					
		}
		
		clean_cleanup_calibre_folder(){
			:
		}
		
		clean_import_folder_doc(){		
			
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
		
		clean_import_folder_evernote(){
			
			:
		}
		
		clean_import_folder_mendely(){
			
			:
		}
		
		clean_import_folder_reference(){
			
			:
		}
		
		clean_import_folder_support(){
		
			:
		}
					
		change_drive $1
		clean_cleanup_thunderbird_folder
		clean_cleanup_calibre_folder
		clean_import_folder_doc
		clean_import_folder_evernote
		clean_import_folder_mendely
		clean_import_folder_reference
		clean_import_folder_support
		
	}
	
	clean_feeds_folder(){
	
		echo
		
	}
		
	clean_film_folder(){
	
		# $1 contains the drive letter
	
		change_drive(){
		
			# change the folder				
			# i tried a lot of way to get 
			# it via a variable,bash simply won't allow that
			# so direct push
			echo " drive : $1"
			case $1 in
				d|D)
					pushd "D:\Inbox\film" > /dev/null 2>&1
					playlist="D:\Dropbox\do\reference\20150319-d-film.m3u"
				;;
				w|W)
					pushd "W:\Inbox\film" > /dev/null 2>&1
					playlist="D:\Dropbox\do\reference\20160422-w-film.m3u"
					;;		
				x|X) 
					pushd "X:\Inbox\film" > /dev/null 2>&1
					playlist="D:\Dropbox\do\reference\20160601-x-film.m3u"
					;;		
				y|Y) 
					pushd "Y:\Inbox\film" > /dev/null 2>&1
					playlist="D:\Dropbox\do\reference\20150319-y-film.m3u"
					;;
				z|Z)
					pushd "Z:\Inbox\film" > /dev/null 2>&1
					playlist="D:\Dropbox\do\reference\20170120-z-film.m3u"
					;;
				*) 
					echo "unknown drive"; 
					return;
				;;
			esac	
			return
		}
		
		rename_files(){
		
			# What this function do
			# - traverse through all directories
			# - for each file
			#	- extract name till the year part `name (year)`
			#	- replace underscore with space in file name
			#	- replace dot with space in file name
			#	- replace multiple space with single space in file name
			#	- replace multiple dashes with single dash in file name
			#	- trim whitespace in filename
			#	- trim whitespace in extension
			#	- add folder name to file name
			#	- rename files
			
			# read only directories
			
			
			for d in */ ; do
				
				# change directory
				cd "$d"			
				echo "  $d"
				
				# remove current log file
				rm log.txt > /dev/null 2>&1
				
				# loop through files
				for f in *; do			
					
					# skip directories
					if [[ -d $f ]]; then continue; fi 
					# skip ini files
					if [[ $f == *.ini ]]; then continue; fi 

					# createdate=$(file_get_created_date "$f")					
					
					# strip relevant details after year
					newname="$(echo $f | sed 's/\(.*\)\([0-9]\{4\}\)\(.*\)/\1\2/g')"
									
					# newname=$(string_convert_to_lower "$newname")
					newname=$(string_replace_underscore_with_space "$newname")
					newname=$(string_replace_brackets_with_space "$newname")									
					newname=$(string_replace_url "$newname")
					newname=$(string_replace_dash_with_space "$newname")
					newname=$(string_replace_dot_with_space "$newname")
					newname=$(string_unify_multiple_spaces "$newname")
					newname=$(string_unify_multiple_dash "$newname")
					
					# add the brackets back to year
					newname="$(echo $newname | sed 's/\(.*\)\([0-9]\{4\}\)\(.*\)/\1\(\2\)\3/g')"
					
					filename=$(string_get_file_name "$newname")
					extension=$(string_get_file_extension "$f")
					folder=${d%/}				
																					
					newfilename=$(string_trim_whitespace "$filename")
					newextension=$(string_trim_whitespace "$extension")
								
					newname="$(echo $newfilename $folder.$newextension)"
															
					# rename, move and index					
					mv "$f" "../../../film/$newname";
										
					p=$(readlink -f "../../../film/$newname")
					winp=$(cygpath -w "$p")
					
					extension="${newname##*.}"					
					# skip the subtitle file					
					# echo $extension
					[[ ! $extension =~ srt|sub|idx|jpg ]]  &&  echo "$winp" >>$playlist
					
					# write to log
					echo "	$f : $newname"
					# add a log file					
					echo "$winp : $f" >>"log.txt"					
										
				done
					# open the log file
					if [ -f "log.txt" ];then
						cygstart "log.txt"				
					fi						
				cd ..						
			done			
		}
		
		change_drive $1
		rename_files
		
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
        echo "inbox [OPTIONS]"     
		echo		
        echo " helper script to manage inbox folders"   
		echo
		echo " OPTIONS"
		echo " ......."
		echo 
		echo "  clean [course]|[film] "
		echo "  help "        		
	}
	
	drive="d"
	
	get_drive(){			
		read -p "enter the drive you want to process( d | w | x | y | z) : "  opted		
		[[ $opted =~ [d|w|x|y|z] ]] && { drive=$opted; } || { echo "ERROR : Unknown drive. Program now EXIT " ; return; }			
	}
	
	# set -x
	ACTION=$1
	shift	

	# Get option
    option=$1;  
    shift

    # Get rest of them
    term="$@"
		
	# Validate the input options
    re="^(clean|help)$"
    if [[ "$ACTION"=~$re ]]; then
        case $ACTION in
        'help')
            usage
            ;;
        'clean') 			
            if [[ -z "$option" ]]; then			
               echo "inbox error : few arguments"
			   return			                  
            else     
			   get_drive
               case "$option" in
                    film) clean_film_folder $drive;;                        
                    course) clean_course_folder $drive;;	                                                              
               esac
            fi              
            ;;       
        esac
    else
        echo "workflow error: unrecognised option \"$option\"."
        echo "try \" view help\" to get more information."
    fi
	
}