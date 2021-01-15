foreach ($d in $(Get-ChildItem C:\Users\ -Directory)) {
    Get-ChildItem "$($d.FullName)\AppData\Roaming" -Directory -Recurse -Filter "Flash Player" -ErrorAction SilentlyContinue | Select-Object -Property FullName
    #Get-ChildItem "$($d.FullName)\AppData\Roaming" -Directory -Recurse -Filter "Flash Player" -ErrorAction SilentlyContinue | Remove-Item -Recurse
}