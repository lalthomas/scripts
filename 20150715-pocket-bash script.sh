# Filename : 20150715-pocket-bash script.sh
# Author : Lal Thomas 
# Date : 2015-07-15
# © Lal Thomas (lal.thomas.mail@gmail.com)


mailtopocket() {
	echo "$1" | mail -s "$1" "add@getpocket.com"
}
alias mailtopocket=mailtopocket


