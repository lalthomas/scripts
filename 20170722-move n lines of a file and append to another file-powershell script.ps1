param ( 
	[Parameter(Mandatory = $true)][string]$sourcefile,
	[Parameter(Mandatory = $true)][string]$destinationfile,
	[Parameter(Mandatory = $true)][Decimal]$limit
)

# echo "source : $sourcefile"
# echo "destination : $destinationfile"
# echo "limit : $limit"

# add new line to destination file
echo '' >>$destinationfile

# copy first n lines  of source file to destination file
Get-Content $sourcefile | select -First $limit >> $destinationfile

# remove those line from source file
(Get-Content $sourcefile | Select-Object -Skip $limit) | Set-Content $sourcefile
