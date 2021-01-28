<#
.SYNOPSIS
    Helper tool to allow officers to add or change their car config for Vigilant Mobile LPR
.DESCRIPTION
    The script presents a menu of "cars" and waits for a selection. Once selected, it attempts to update their local Vigilant LPR install with the correct config file.
.NOTES
    Author(s):  David Hatch
    Version:    1.3
    Updating Menu: Simply update the config files in \\sccm01v\Apps\Vigilant LPR\LPR\ and make sure their name matches the pattern "system_*.ini"
#>
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
    
    Write-Host "Press 'q' to quit"
}


Show-Menu "Car Selector"
echo ''
$opt = Read-Host "Please select your car (enter number 1-$optCount)"

# Look for valid options ex. 1-6
if ($opt -match "^[1-$optCount]$") {
    $opt -= 1

    # Delete any exisitng config and then copy the selected car's config file
    rm $installPath\system_*.ini
    copy $configFiles[$opt] $installPath
    if ($?) {
        "Installed file {0}`nDone!" -f ($configFiles[$opt].Name)
        pause
    }
}
