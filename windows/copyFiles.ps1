Get-ExecutionPolicy
Set-Variable -name myPath -value $env:APPDATA\Mozilla\Firefox\Profiles
$fileList = 'places.sqlite',
            'key3.db',
            'signons.sqlite',
            'formhistory.sqlite'

if (Test-Path $myPath) {
    $folders = Get-ChildItem $myPath | sort creationtime | select -last 2
    $oldProfile = $folders[0].FullName
    $newProfile = $folders[1].FullName
    foreach ($file in $fileList) {
        if (Test-Path $oldProfile\$file) {
            Copy-Item $oldProfile\$file $newProfile
            "$file copied"
        } else {
            "$file not copied"
        }
    }
} else {
    "Folder does not exist"
}