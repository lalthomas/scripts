#!/bin/bash -x

# Filename : 20160509-inbox folder-bash script.sh
# Author : Lal Thomas 
# Date : 2016-05-09
# © Lal Thomas (lal.thomas.mail@gmail.com)

alias inbox=_inbox_

_inbox_(){	

	# generic routines
	
	sirenpath="D:\Portable App\siren\siren.exe"
	
	array_contains() { 
		# thanks: http://stackoverflow.com/a/14367368/2182047
		# array name
		local array="$1[@]"
		# seeking string
		local seeking=$2
		local in=1
		for element in "${!array}"; do
			if [[ $element == $seeking ]]; then
				in=0
				break
			fi
		done
		return $in
	}	
	
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
					newname=$(string_convert_to_lower "$newname")
					
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
				
				# count the number of files
				shopt -s nullglob
				numfiles=(*)
				numfiles=${#numfiles[@]}								
				if [[ $numfiles -eq 0 ]]; then return; fi
				
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
	
		# $1 contains the drive letter
	
		change_drive(){
		
			# change the folder				
			# i tried a lot of way to get 
			# it via a variable,bash simply won't allow that
			# so direct push
			echo " drive : $1"
			case $1 in
				d|D)
					pushd "D:\Inbox\picture" > /dev/null 2>&1					
					;;
				w|W)
					pushd "W:\Inbox\picture" > /dev/null 2>&1					
					;;		
				x|X) 
					pushd "X:\Inbox\picture" > /dev/null 2>&1					
					;;		
				y|Y) 
					pushd "Y:\Inbox\picture" > /dev/null 2>&1					
					;;
				z|Z)
					pushd "Z:\Inbox\picture" > /dev/null 2>&1					
					;;
				*) 
					echo "unknown drive"; 
					return;
				;;
			esac	
			return
		}
		
		process(){			
		
		for d in */ ; do
			# change directory
			cd "$d"
			echo "  $d"
			# echo "  ${d%/}"			
			# folders list			
			camera_roll_list=("lenovo camera roll" "lumia camera roll" "mipad camera roll" "sony cybershot camera roll")
			
			array_contains camera_roll_list "${d%/}" && {			
															
				# open siren commandline and rename files							
				# rename with image with format <date taken>-<timetaken> <model name> camera roll image.<extension>
				
				# rename
				cygstart --wait \
						  "$(cygpath -u "${sirenpath}")" \
						  "--dir \"$(cygpath -w "${PWD}")\" \
						  --filter \"*.jpg\" \	
						  --select \"*.*\" \
						  --expression %Xdod-%Xdot\" \"%lXmo\" \"camera\" \"roll\" \"image.%le \
						  --rename \
						  --quit"							
				# move and index
				mkdir '../../../Pictures/camera roll' > /dev/null 2>&1
				find . -type f -name '*.jpg' -exec mv {} '../../../Pictures/camera roll' \;				
				
				# for f in *.jpg; do					
					# echo "$f"					
				# done
			}
			
			saved_pictures_list=("computer saved pictures" "lumia saved pictures" "mipad saved pictures")
			
			array_contains saved_pictures_list "${d%/}" && {
			
				# open siren commandline and rename files
				
				# rename as date-<sha1>.<ext>
				cygstart --wait \
						  "$(cygpath -u "${sirenpath}")" \
						  "--dir \"$(cygpath -w "${PWD}")\" \
						  --filter \"*.jpg;*.png;*.gif\" \	
						  --select \"*.*\" \
						  --expression %dcd-%cs.%le \
						  --rename \
						  --quit"							
				# move and index
				mkdir '../../../Pictures/saved pictures' > /dev/null 2>&1
				find . -type f \( -name "*.jpg" -or -name "*.png" -or -name "*.gif" \) -exec mv {} '../../../Pictures/saved pictures' \;
			}
			
			
			saved_photos_list=("computer saved photos" "mipad saved photos")
			
			array_contains saved_photos_list "${d%/}" && {
			
				# open siren commandline and rename files
				
				# rename as date-<sha1>.<ext>
				cygstart --wait \
						  "$(cygpath -u "${sirenpath}")" \
						  "--dir \"$(cygpath -w "${PWD}")\" \
						  --filter \"*.jpg;*.png;*.gif\" \	
						  --select \"*.*\" \
						  --expression %dcd-%cs.%le \
						  --rename \
						  --quit"				
				# move and index
				mkdir '../../../Pictures/saved photos' > /dev/null 2>&1
				find . -type f \( -name "*.jpg" -or -name "*.png" -or -name "*.gif" \) -exec mv {} '../../../Pictures/saved photos' \;
			}
			
						
			scanned_images_list=("hp scanner images" "lumia camera roll scans" "mipad camera roll scans")
			
			array_contains scanned_images_list "${d%/}" && {
			
				# add filename as caption for hp scanner images
				if [  "${d%/}" == "hp scanner images" ]; then				
					local captionscriptpath="20160526-add caption for image-dos batch script.bat"				
					cygstart --wait "$scriptfolder/$(cygpath -u "${captionscriptpath}")" \"$(cygpath -w "${PWD}")\"
				fi
				
				# open siren commandline and rename files
				# rename as <date>-<sha1>.<ext>
				cygstart --wait \
						  "$(cygpath -u "${sirenpath}")" \
						  "--dir \"$(cygpath -w "${PWD}")\" \
						  --filter \"*.jpg;*.png;*.gif\" \	
						  --select \"*.*\" \
						  --expression %dcd-%dct-%cs.%le \
						  --rename \
						  --quit"				
				
				# move and index
				mkdir '../../../Pictures/scanned images' > /dev/null 2>&1
				find . -type f \( -name "*.jpg" -or -name "*.png" -or -name "*.gif" \) -exec mv {} '../../../Pictures/scanned images' \;
				
				# organize based on date
				pushd "../../../Pictures/scanned images" > /dev/null 2>&1	
				find . -maxdepth 1 -type f \( -name "*.jpg" -or -name "*.png" -or -name "*.gif" \) | 
				while IFS= read -r file; do
					## Get the file's modification year					
					fdate="$(date -d "$(stat -c %y "$file")" +%Y%m%d)"
					## Create the directories if they don't exist. The -p flag
					## makes 'mkdir' create the parent directories as needed so
					## you don't need to create $fdate explicitly.
					[[ ! -d "$fdate" ]] && mkdir -p "$fdate"; 
					## Move the file
					mv "$file" "$fdate"
				done
				popd > /dev/null 2>&1	

			}
			
			# wallpaper
			
			if [  "${d%/}" == "wallpapers" ]; then
								
			    # check whether there is subfolders
				subdircount=`find $PWD -maxdepth 1 -type d | wc -l`				
				if [ $subdircount -gt 1 ]
				then
					echo "Processing tag folders"
					# for each sub folder create tag on image
					for w in */ ; do
						# change directory
						cd "$w"
						echo "   $w"					
						# set the folder name as tag name
						local pgmpath="20160216-set folder name as tag for image-dos batch script.bat"		
						cygstart --wait "$scriptfolder/$(cygpath -u "${pgmpath}")" \"$(cygpath -w "${PWD}")\"
						# fix the tag name of image
						local fixtagscriptpath="20160217-fix the tag name of image-dos batch script.bat"		
						cygstart --wait "$scriptfolder/$(cygpath -u "${fixtagscriptpath}")" \"$(cygpath -w "${PWD}")\"
						# add caption for image
						local captionscriptpath="20160526-add caption for image-dos batch script.bat"				
						cygstart --wait "$scriptfolder/$(cygpath -u "${captionscriptpath}")" \"$(cygpath -w "${PWD}")\"				
						# move all files parent folder
						mv * .[^.]* .. > /dev/null 2>&1															
						# pop path
						cd ..
					done															
				fi
												
				# remove empty folders
				# find . -empty -type d -delete				
				
				# rename the file using <sha1>.<ext>				
				cygstart --wait \
						  "$(cygpath -u "${sirenpath}")" \
						  "--dir \"$(cygpath -w "${PWD}")\" \
						  --filter \"*.jpg;*.png;*.gif\" \	
						  --select \"*.*\" \
						  --expression %cs.%e \
						  --rename \
						  --quit"
				# move the file to wallpaper folder
				mkdir -p '../../../Wallpapers'  > /dev/null 2>&1
				find . -type f \( -name "*.jpg" -or -name "*.png" -or -name "*.gif" \) -exec mv {} '../../../Wallpapers' \;
				
				# organize wallpapers based on year
				pushd "../../../Wallpapers" > /dev/null 2>&1	
				find . -maxdepth 1 -type f \( -name "*.jpg" -or -name "*.png" -or -name "*.gif" \) | 
				while IFS= read -r file; do
					## Get the file's modification year
					year="$(date -d "$(stat -c %y "$file")" +%Y)"
					## Create the directories if they don't exist. The -p flag
					## makes 'mkdir' create the parent directories as needed so
					## you don't need to create $year explicitly.
					[[ ! -d "$year" ]] && mkdir -p "$year"; 
					## Move the file
					mv "$file" "$year"
				done
				popd > /dev/null 2>&1	

			fi
			
			cd ..
		done		
				
		# newfile=$(openssl sha1 $file)
		
		# process also following folders
		# 
		# 	albums
		#	hp scanner images
		#	import evernote
		#	lenovo screenshots
		#	lumia camera roll scans
		#	mipad camera roll scans
		#	wallpaper

		}
		
		change_drive $1
		process 
				
	}
	
	clean_resource_folder(){
	
		echo
	}
		
	clean_sound_folder(){
		
		echo
		
	}
		
	clean_tool_folder(){
	
		change_drive(){
		
			# change the folder				
			# i tried a lot of way to get 
			# it via a variable,bash simply won't allow that
			# so direct push
			echo " drive : $1"
			case $1 in
				d|D)
					pushd "D:\Inbox\tool" > /dev/null 2>&1					
				;;
				w|W)
					pushd "W:\Inbox\tool" > /dev/null 2>&1					
					;;		
				x|X) 
					pushd "X:\Inbox\tool" > /dev/null 2>&1					
					;;		
				y|Y) 
					pushd "Y:\Inbox\tool" > /dev/null 2>&1					
					;;
				z|Z)
					pushd "Z:\Inbox\tool" > /dev/null 2>&1				
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
				
				# count the number of files
				shopt -s nullglob
				numfiles=(*)
				numfiles=${#numfiles[@]}
				
				if [[ $numfiles -gt 1 ]]; then 
				
					# remove current log file
					rm log.txt > /dev/null 2>&1
					
					# remove current log file
					rm log.txt > /dev/null 2>&1
					
					# get folder name
					folder=${d%/}
					
					# loop through files
					for f in *; do			
							
							# skip directories
							if [[ -d $f ]]; then continue; fi 
							# skip ini files
							if [[ $f == *.ini ]]; then continue; fi 

							createdate=$(file_get_created_date "$f")				
						
							# strip relevant details after year
							filename=$(string_get_file_name "$f")
							extension=$(string_get_file_extension "$f")
						
							
							newname=${filename#${folder}}
							# end of remove folder name
						
							newname=$(string_replace_underscore_with_space "$newname")
							newname=$(string_replace_brackets_with_space "$newname")									
							newname=$(string_replace_url "$newname")
							newname=$(string_replace_dash_with_space "$newname")					
							newname=$(string_unify_multiple_spaces "$newname")
							newname=$(string_unify_multiple_dash "$newname")
							newname=$(string_convert_to_lower "$newname")
							newfilename=$(string_trim_whitespace "$newname")
							newextension=$(string_trim_whitespace "$extension")					
							newname="$(echo $createdate-$newfilename.$newextension)"											
						
																	
							# rename, move and index					
							mv "$f" "../../../Tools/$newname";
												
							p=$(readlink -f "../../../Tools/$newname")
							winp=$(cygpath -w "$p")
							
							extension="${newname##*.}"					
							# skip the subtitle file					
							# echo $extension
							toolindexfile="D:\Dropbox\do\reference\20160126-software tools-dev index.csv"
							[[ ! $extension =~ srt|sub|idx|jpg ]]  &&  echo "\"${folder}\",\"${winp}\"" >>"${toolindexfile}"
							
							# write to log
							echo "	$f : $newname"
							# add a log file					
							echo "$winp : $f" >>"log.txt"					
												
						done
						# open the log file
						if [ -f "log.txt" ];then
							cygstart "log.txt"				
						fi	
					fi					
				cd ..						
			done			
		}
		change_drive $1
		rename_files
		
		# remove from stack
		popd > /dev/null 2>&1
	
	}
	
	clean_video_folder(){
	
		# $1 contains the drive letter
	
		change_drive(){
		
			# change the folder				
			# i tried a lot of way to get 
			# it via a variable,bash simply won't allow that
			# so direct push
			echo " drive : $1"
			case $1 in
				d|D)
					pushd "D:\Inbox\video" > /dev/null 2>&1
					savedplaylist="D:\Dropbox\do\reference\20150319-d-videos-saved.m3u"
					camerarollplaylist="D:\Dropbox\do\reference\20170425-d-videos-cameraroll.m3u"
					developerplaylist="D:\Dropbox\do\reference\20170425-d-videos-developer.m3u"
					songplaylist="D:\Dropbox\do\reference\20170425-d-videos-song.m3u"					
					tvplaylist="D:\Dropbox\do\reference\20150411-d-video-tv.m3u"
					likedplaylist="D:\Dropbox\do\reference\20150411-d-video-liked.m3u"
					;;
				w|W)
					pushd "W:\Inbox\video" > /dev/null 2>&1
					savedplaylist="D:\Dropbox\do\reference\20160503-w-videos-saved.m3u"
					camerarollplaylist="D:\Dropbox\do\reference\20170425-w-videos-cameraroll.m3u"
					developerplaylist="D:\Dropbox\do\reference\20170425-w-videos-developer.m3u"
					songplaylist="D:\Dropbox\do\reference\20170425-w-videos-song.m3u"
					tvplaylist="D:\Dropbox\do\reference\20150411-w-video-tv.m3u"
					likedplaylist="D:\Dropbox\do\reference\20150411-w-video-liked.m3u"
					;;		
				x|X) 
					pushd "X:\Inbox\video" > /dev/null 2>&1
					savedplaylist="D:\Dropbox\do\reference\20150319-x-video-saved videos.m3u"
					camerarollplaylist="D:\Dropbox\do\reference\20170425-x-videos-cameraroll.m3u"
					developerplaylist="D:\Dropbox\do\reference\20150411-x-video-developer.m3u"
					songplaylist="D:\Dropbox\do\reference\20150319-x-video-songs.m3u"
					tvplaylist="D:\Dropbox\do\reference\20150411-x-video-tv.m3u"
					likedplaylist="D:\Dropbox\do\reference\20150411-x-video-liked.m3u"
					;;		
				y|Y) 
					pushd "Y:\Inbox\video" > /dev/null 2>&1					
					savedplaylist="D:\Dropbox\do\reference\20150319-y-video-saved.m3u"
					camerarollplaylist="D:\Dropbox\do\reference\20170425-y-videos-cameraroll.m3u"
					developerplaylist="D:\Dropbox\do\reference\20170425-y-video-developer.m3u"
					songplaylist="D:\Dropbox\do\reference\20150319-y-video-songs.m3u"
					tvplaylist="D:\Dropbox\do\reference\20150319-y-video-tv.m3u"
					likedplaylist="D:\Dropbox\do\reference\20150411-y-video-liked.m3u"

					;;
				z|Z)
					pushd "Z:\Inbox\video" > /dev/null 2>&1	
					savedplaylist="D:\Dropbox\do\reference\20150319-z-video-saved.m3u"
					camerarollplaylist="D:\Dropbox\do\reference\20170425-z-videos-cameraroll.m3u"
					developerplaylist="D:\Dropbox\do\reference\20170425-z-video-developer.m3u"
					songplaylist="D:\Dropbox\do\reference\20150319-z-video-songs.m3u"
					tvplaylist="D:\Dropbox\do\reference\20150319-z-video-tv.m3u"
					likedplaylist="D:\Dropbox\do\reference\20150411-z-video-liked.m3u"
					;;
				*) 
					echo "unknown drive"; 
					return;
				;;
			esac	
			return
		}
		process(){
		loop_files(){
					
			folder=$1
			movepath=$2
			# echo $folder
			# echo $movepath				
			
			# count the number of files
			shopt -s nullglob
			numfiles=(*)
			numfiles=${#numfiles[@]}								
			if [[ $numfiles -eq 0 ]]; then return; fi
			
			# loop through all files in the current folder
			for f in *; do			
			
				# skip directories
				if [[ -d $f ]]; then continue; fi 
				# skip ini files
				if [[ $f == *.ini ]]; then continue; fi 
				# skip log files
				if [[ $f == log.txt ]]; then continue; fi 
				
				createdate=$(file_get_created_date "$f")				
				
				# strip relevant details after year
				filename=$(string_get_file_name "$f")
				extension=$(string_get_file_extension "$f")
				
				# remove folder name
				folder=${folder%/}				
				newname=${filename#${folder}}
				# end of remove folder name
				
				newname=$(string_replace_underscore_with_space "$newname")
				newname=$(string_replace_brackets_with_space "$newname")									
				newname=$(string_replace_url "$newname")
				newname=$(string_replace_dash_with_space "$newname")
				newname=$(string_replace_dot_with_space "$newname")
				newname=$(string_unify_multiple_spaces "$newname")
				newname=$(string_unify_multiple_dash "$newname")
				newfilename=$(string_trim_whitespace "$newname")
				newextension=$(string_trim_whitespace "$extension")
				
				newname="$(echo $createdate-$newfilename $folder.$newextension)"											
				
				if [  "${folder}" == "liked video" ]; then
					newname="$(echo $createdate-$newfilename.$newextension)"
				fi

				if [  "${folder}" == "saved video" ]; then
					newname="$(echo $createdate-$newfilename.$newextension)"
				fi

				newname=$(string_convert_to_lower "$newname")
				
				# rename, move and index					
				mv "$f" "$movepath/$newname";						
				p=$(readlink -f "$movepath/$newname")
				winp=$(cygpath -w "$p")
				
				extension="${newname##*.}"
				# skip the subtitle file					
				# echo $extension
				[[ ! $extension =~ srt|sub|idx|jpg ]]  &&  echo "$winp" >>$playlist
				
				# write to log
				echo "	$f : $newname"
				# add a log file					
				# echo "$winp : $f" >>"log.txt"									
			done
		}					
		
		for d in */ ; do
			# change directory
			cd "$d"
			echo "  $d"
			folder=${d%/}
			# echo "  ${d%/}"			
			# folders list
			
			# remove current log file
			rm log.txt > /dev/null 2>&1
			# loop through files
			
				
			if [  "${d%/}" == "saved video" ]; then												
				dirpath='../../../Videos/saved'					
				playlist=$savedplaylist							
			fi
			
			if [  "${d%/}" == "liked video" ]; then												
				dirpath='../../../Videos/liked'					
				playlist=$likedplaylist					
			fi
		
			if [  "${d%/}" == "developer video" ]; then
				dirpath='../../../Videos/developer'					
				playlist=$developerplaylist					
			fi
			
			liked_list=("short film" "audio video" "english documentary" "malayalam documentary")
			array_contains liked_list "${d%/}" && {		
				dirpath='../../../Videos/liked'												
				playlist=$tvplaylist										
			}
			
			song_list=("english song" "hindi song" "tamil song" "malayalam song" "film trailer" )			
			array_contains song_list "${d%/}" && {																	
				dirpath='../../../Videos/song'									
				playlist=$songplaylist									
			}
			
			mkdir $dirpath > /dev/null 2>&1
			loop_files "$folder" "$dirpath"
		cd ..
		done	
	}
		
	change_drive $1
	mkdir "../../../Videos/" > /dev/null 2>&1
	process 
		
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
		echo "  clean [course]|[film]|[picture]|[video][tool] "
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
					picture) clean_picture_folder $drive;;
					video) clean_video_folder $drive;;
					tool) clean_tool_folder $drive;;
               esac
            fi              
            ;;       
        esac
    else
        echo "workflow error: unrecognised option \"$option\"."
        echo "try \" view help\" to get more information."
    fi
	
}