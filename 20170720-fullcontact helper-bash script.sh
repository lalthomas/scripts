#!/bin/bash -x

# Filename : 20170720-fullcontact helper-bash script.sh
# Author : Lal Thomas 
# Date : 2017-07-20
# © Lal Thomas (lal.thomas.mail@gmail.com)

# initialize global variables 
currentScriptFolder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

alias fullcontact=_fullcontact_main_

# api key f4c1d327ccd42d3

# curl -H"X-FullContact-APIKey:f4c1d327ccd42d3" 'https://api.fullcontact.com/v2/person.json?email=lal.thomas.mail@gmail.com'
_fullcontact_main_(){

	_usage(){
	
		echo "NOT Implemented"
		echo "fullcontact <options>		"
		echo "					"
		echo "options			"
		echo "					"
		echo "help"		
	}
	
	# Get action
	action=$1
	shift

	case $action in
	help|usage) _usage;;	
	esac
	
}