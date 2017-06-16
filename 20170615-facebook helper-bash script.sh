
datafile="data.json"
picfile="pic.json"
token="EAACEdEose0cBAIXxgk1wFQgJGkuMsTL0vJ7tVcVUn4twGsZCbvxsbhTZB9xDFZC6uYvthZBAtUFAZAJ4DlIIgn1ISLaQGls7IV97ID5ZBM0H1DqGy20kR7bVUXYZCk0fyIjxGqcPjsBbtmA4rFf1XsFeM6jVFeNUYyoRerQgBhXlJfUPLHiqSpN4bgKvRtJKZAAZD"

getfacebookwebdata(){

	local facebookID=$1
	curl -X GET  "https://graph.facebook.com/v2.9/$facebookID?fields=id%2Cname%2Cgender%2Clink%2Cpicture&access_token=$token" >"$datafile"
	
}


getfacebookPic(){

	local facebookID=$1	
	curl -X GET "https://graph.facebook.com/$facebookID/picture?type=large&redirect=false" >"$picfile"		
	URL=$(cat "$picfile" |./jq -r '.data.url')	
	# thanks https://stackoverflow.com/a/35019553/2182047
	URL=${URL%$'\r'}
	echo $URL
	curl -X GET $URL >"$facebookID.jpg"
		
}


getfacebookBigPic(){
	
	local facebookID=$1		
	curl -L -X GET "https://graph.facebook.com/$facebookID/picture?type=large&width=500&height=500"  >"$facebookID.jpg"
	
}

value(){

	local type=$1
	cat "$datafile" |  python -c "import json,sys;obj=json.load(sys.stdin);print obj['$type'];"	
	
}


# getfacebookPic 100002463983373
# getfacebookBigPic 100002463983373
# getfacebookBigPic 100002616246102
getfacebookBigPic 100000255382519


# getfacebookwebdata 100002463983373
# value "id"
# value "name"
# value "link"