#!/bin/bash -x

# Filename : 20160509-inbox folder-bash script.sh
# Author : Lal Thomas 
# Date : 2016-05-09
# © Lal Thomas (lal.thomas.mail@gmail.com)

# initialize global variables 
currentScriptFolder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

alias inbox=_inbox_

_inbox_(){	
	
	usage(){

        echo 
        echo "Inbox OPTIONS"      
        echo " helper script to managing inbox folder"   
        echo 
		
	}
	
	ACTION=$1
	shift
	
	case "$ACTION" in		
		help|usage)	usage ;;		
	esac

}