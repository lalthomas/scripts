#!/bin/bash -x

# Filename : 20160509-inbox folder-bash script.sh
# Author : Lal Thomas 
# Date : 2016-05-09
# © Lal Thomas (lal.thomas.mail@gmail.com)

# initialize global variables 
currentScriptFolder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

alias inbox=_inbox_

_inbox_(){	

	convert2lowercase(){
	
		echo "Converting filenames to lowercase"
		
	}

	clean_mail_chumma(){
		
		for f in *; do
			if [[ -d $f ]]; then continue; fi # skip directories	
			newname="$(echo $f | sed 's/_/ /g')" # substitute underscore with space
			newname="$(echo $newname | sed 's/\[[0-9] Attachment\]//g')" 			
			newname="$(echo $newname | sed 's/--/-/g')" # substitute underscore with space						
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
			
	}
		
	clean_doc_docs_names(){
	 
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
	}
	
	clean_doc_calibre_periodical(){
		
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
			mv "$f" "$newname"; # rename the files
		done
	
	}
	
	usage(){

        echo 
        echo "Inbox OPTIONS"      
        echo " helper script to managing inbox folder"   
		echo "clean_doc_calibre_periodical"
		echo "clean_mail_chumma"
        echo "clean_doc_docs_names"		
	}
			
	ACTION=$1
	shift
	
	case "$ACTION" in		
		help|usage)	usage ;;
		clean_doc_calibre_periodical) clean_doc_calibre_periodical;;		
		clean_doc_docs_names) clean_doc_docs_names;;
		clean_mail_chumma) clean_mail_chumma;;
	esac

}