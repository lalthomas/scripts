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
        echo " helper script to managing wallpaper folder"   
        echo 
        echo "OPTIONS are..."
        echo 				
		echo "usage"		
		echo 
		echo "e.g. wallpaper usage"
		echo 
		
	}
	
	
	drive=$1
	shift
	
	[[ $drive =~ [d|w|x|y|z] ]] && { drive=$opted; } || { echo "ERROR : Unknown drive. Program now EXIT " ; return 1; }
	
	option=$1
	shift
	
	pushd "$drive:\Dropbox\project" > /dev/null 2>&1
	echo $PWD
	case "$option" in				
		help|usage)	usage ;;
	esac	
	popd  > /dev/null 2>&1
	
}