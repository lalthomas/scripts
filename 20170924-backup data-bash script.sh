#!/bin/bash -x

# Filename : 20170924-backup data-bash script.sh
# Author : Lal Thomas 
# Date : 2017-09-24
# © Lal Thomas (lal.thomas.mail@gmail.com)

alias backup=_backup_

_backup_(){

	read -n1 -r -p "connect w drive and press any key to backup..." key </dev/tty
	rsync –av --recursive --delete "/cygdrive/d/do" "/cygdrive/w/Backups/"
	rsync –av --recursive --delete "/cygdrive/d/doc" "/cygdrive/w/Backups/"
	rsync –av --recursive --delete "/cygdrive/d/project" "/cygdrive/w/Backups/"
	
}

# MKISOFS 
# csync 
# osync
