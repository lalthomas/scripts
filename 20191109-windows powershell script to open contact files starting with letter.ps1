# script to filter contact files

$filespath = "E:\17\do\reference"
$firstletter = "M"

cd $filespath

# $Files = Get-ChildItem -Path "$StartMenu\Programs" -Filter *.lnk
$files = Get-ChildItem -Filter "*-$firstletter*contact file.md"

foreach ( $file in $files){

    $filepath = $file.FullName
    explorer $filepath

}

cd ..
