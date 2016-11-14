#!/bin/bash
# script for managing daily work flow
# Copyright (c) Lal Thomas, http://lalamboori.blogspot.in
# License: GPL3, http://www.gnu.org/copyleft/gpl.html

alias gsd='sh "$toolsRootPath/20161026-get-shit-done/get-shit-done.sh"'
alias review=_review_main_

build_prior_knoweledge(){
	
	# start google mail
	cygstart 

}

reviewDay(){     
    
}

reviewWeek(){

    read -p "do you build prior knowledge : " opted
	if [ $opted == "y" ]; then
		build_prior_knoweledge
	fi
}

reviewMonth(){
    	
}

reviewYear(){

}

_review_main_(){

    # Get action
    action=$1
    shift

    # Get option
    option=$1;  
    shift

    # Get rest of them
    term="$@"

    # echo action: $action option: $option term: $term

    # Validate the input options
    re="^(help|review)$"
    if [[ "$action"=~$re ]]; then
        case $action in
        'help')
            usage
            ;;
        'review')        
            if [[ -z "$option" ]]; then
               echo "review error : few arguments"
               #adddonUsage
            else                
               case "$option" in
                    day)
                        reviewDay
                        ;;
                    week)
                        reviewWeek
                        ;;                  
                    month)
                        reviewMonth
                        ;;
                    year)
                        reviewYear
                        ;;
                    esac
            fi              
            ;;        
        esac
    else
        echo "review error: unrecognized option \"$option\"."
        echo "try \" view help\" to get more information."
    fi
}