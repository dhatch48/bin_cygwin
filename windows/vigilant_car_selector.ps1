
$installPath = 'C:\Program Files (x86)\Vigilant Solutions\Vigilant Mobile LPR'
$sourcePath = '\\sccm01v\Apps\Vigilant LPR\LPR'
$configFiles = (ls $sourcePath\system_*.ini)
$optCount = ($configFiles.Count)


function Show-Menu {
    param (
        [string]$Title = 'My Menu'
    )
    Clear-Host
    echo "========== $Title =========="
    foreach ($file in $configFiles) {
        '{0}: {1}' -f ($configFiles.IndexOf($file)+1),($file.BaseName.Substring(7))
    }
    
    Write-Host "q: Press 'q' to quit"
}


Show-Menu "Car Selector"
echo ''
$opt = Read-Host "Please select your car"

# Look for valid options (ex. 1-6)
if ($opt -match "^[1-$optCount]$") {
    $opt -= 1

    # Delete any exisitng config and then copy the selected car's config file
    rm $installPath\system_*.ini
    copy $configFiles[$opt] $installPath
    "Installed file {0}`nDone!" -f ($configFiles[$opt].Name)
    pause
}