#!/bin/bash -x

# Filename : 20160225-reference folder-bash script.sh
# Author : Lal Thomas 
# Date : 2017-04-05
# © Lal Thomas (lal.thomas.mail@gmail.com)

# initialize global variables 
# do scripts variables

currentScriptFolder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
alias referencefolder=_reference_main_

_reference_main_(){
	
	commit(){

		g repo commit '$referenceRootPath' "update files"
	
	}

	contactCreate(){
	
		# thanks http://www.folkstalk.com/2012/07/bash-shell-script-to-read-parse-comma.html
		INPUT_FILE='unix_file.csv'
		IFS=','
		while read OS HS
		do
		echo "Operating system - $OS"
		echo "Hosting server type - $HS"
		done < $INPUT_FILE
	
	}
	
}

