#!/bin/bash -x

# Filename : 20170924-backup data-bash script.sh
# Author : Lal Thomas 
# Date : 2017-09-24
# © Lal Thomas (lal.thomas.mail@gmail.com)

alias backup=_backup_

_backup_(){

	_warm(){
		
		read -n1 -r -p "connect w drive and press any key to backup..." key </dev/tty
	}
	
	_fav(){
				
		rsync –av --recursive --delete "/cygdrive/d/do" "/cygdrive/y/2019/Backups/"
		rsync –av --recursive --delete "/cygdrive/d/docs" "/cygdrive/y/2019/Backups/"
		rsync –av --recursive --delete "/cygdrive/d/lab" "/cygdrive/y/2019/Backups/"
		rsync –av --recursive --delete "/cygdrive/d/searches" "/cygdrive/y/2019/Backups/"
		rsync –av --recursive --delete "/cygdrive/d/write" "/cygdrive/y/2019/Backups/"
		
	}
	
	
	_all(){
		
		rsync –av --recursive --delete "/cygdrive/d/" "/cygdrive/y/2019/Backups/"
	}

	_usage(){
	
		echo "backup <options>		"
		echo "					"
		echo "options			"
		echo "					"
		echo "help"
		echo "usage"
		echo "all"
		echo "fav"
	}
	
	# Get action
	action=$1
	shift

	case $action in
	help|usage) usage;;
	all) _warm && _all "$@";;		
	fav) _warm && _fav "$@";;
	esac
	
}

# MKISOFS 
# csync 
# osync
