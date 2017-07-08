#!/bin/bash -x

# Filename : 20170706-wallpaper folder-bash script.sh
# Author : Lal Thomas 
# Date : 2017-07-06
# © Lal Thomas (lal.thomas.mail@gmail.com)


alias wallpaper=_wallpaper_main_

_wallpaper_main_(){
	
	usage(){
		
		echo 
        echo "wallpaper OPTIONS"      
		echo
        echo " helper script to managing wallpaper folder"   
        echo 
        echo "OPTIONS are..."
        echo 				
		echo " usage"		
		echo " view"		
		echo " <drive> index keyword"
		echo " <drive> collect keyword"
		echo ""
		echo 
		echo "e.g. wallpaper usage"		
		echo 
		
	}
	
	view(){
	
		filelistpath="$@"		
		irfanviewpath="C:\PortableApps.com\PortableApps\IrfanViewPortable\IrfanViewPortable.exe"
		b path full $filelistpath				
		cygstart --wait $irfanviewpath /slideshow=$(cygpath -w "$B_FILE_FULL_PATH") /closeslideshow
		
	}
	
	show(){
		
		# declare -i i=${1:-$(</dev/stdin)};
		# declare hr=$(($i/3600)) min=$(($i/60%60)) sec=$(($i%60));
		# printf "%02d:%02d:%02d\n" $hr $min $sec;
		
		IFS=''
		declare STDIN_INPUT=${@:-$(</dev/stdin)}
		unset IFS
		
		# # parse each value if needed
		# for PARM in $STDIN_INPUT; do
			# #do what needs to be done on each input value
			# echo "$PARM"
		# done
		
		local tempfile=$RANDOM.tmp
		printf "%s\n" "${STDIN_INPUT[@]}" >$tempfile
		view $tempfile
		# rm $tempfile
		
		
	}
	
	chumma(){
		
		echo $*
		local OPTION
		local OPTARG
		getopts :a: OPTION
		echo "OPTION : "$OPTION
		echo "OPTARG : "$OPTARG
	}
	
	index(){
					
								
		# ./exiftool.exe -r -s -s -s -quiet -iptc:Keywords "$winpath" >"$wallpaperfolder/keywords.txt"
		
		echo $*
		local OPTIND
		local OPTION
		
		getopts :a: OPTION
		echo "OPTION : "${OPTION}
		echo "OPTARG : "${OPTARG}
		
		case ${OPTION} in
		 a)				
			echo "option c is triggered"
			pushd "$scriptfolder\tools\exiftool" > /dev/null 2>&1
			values=$(./exiftool.exe -r -s -s -s -quiet -iptc:Keywords "$winpath" | tr , '\n' |  tr -d "[:blank:]" |  tr -d "\r")				
			popd > /dev/null 2>&1
			printf "Values : %s" $values						
			;;			  
		 \?)
			echo "Invalid option: -$OPTARG" >&2
			;;
		  esac	  	  		  
		
		shift $((OPTIND-1))
				
		# pipeline working
		# - comma is replaced with newline
		# - spaces are removed
		# - line feeds are removed, now the lines only one ending
		# - sorted uniquely
				
		if [ -z "$OPTION" ]; then		
			# no options given
			pushd "$scriptfolder\tools\exiftool" > /dev/null 2>&1		
			./exiftool.exe -r -s -s -s -quiet -iptc:Keywords "$winpath" | tr , '\n' |  tr -d "[:blank:]" |  tr -d "\r" | sort -u 
			popd > /dev/null 2>&1		
		fi
	}	
	
	collect(){
		KEYWORD=$1
		pushd "$scriptfolder\tools\exiftool" > /dev/null 2>&1
		./exiftool.exe -r -q -q -ext .jpg -fast -p '$directory/$filename::$Keywords' -qq -r -m "$winpath" | grep -i "$KEYWORD" | sed -n -e 's/\(.*\)::\(.*\)/\1/p'
		popd > /dev/null 2>&1	 					
	}
	
	option=$1
	shift
	
	case "$option" in						
		usage|help) 
			usage
			return 0;
		;;
		view) 
			view "$@"
			return 0;		
		;;		
		show)
			show "$@"
			return 0;
		;;
	esac 
		
	[[ $option =~ [d|w|x|y|z] ]] && { drive=$option; } || { echo "ERROR : Unknown drive. Program now EXIT " ; return 1; }
	
	option=$1
	shift
	
	wallpaperfolder=$drive:"\Wallpapers"
	winpath="$(cygpath -w "$wallpaperfolder")"
	
	pushd $drive:"\Wallpapers" > /dev/null 2>&1	
	case "$option" in						
		index) index "$@" ;;
		collect) collect "$@";;
		chumma) chumma "$@";;		
	esac	
	popd  > /dev/null 2>&1
	
}