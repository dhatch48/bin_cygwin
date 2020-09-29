<#
.SYNOPSIS
    Updates the scheduled task to remove all commandline arguments except /CM
.DESCRIPTION
    This modifies the default scheduled task that is created when installing System Update.
    Removes direct commandline arguments from task so that arguments can be specified from Group Policy or Registry.
.NOTES
    Created by David Hatch
#>
$su = Join-Path ([System.Environment]::GetFolderPath('ProgramFilesX86')) 'Lenovo\System Update\tvsu.exe'
$taskAction = New-ScheduledTaskAction -Execute $su -Argument '/CM'
$tvTask = Set-ScheduledTask -TaskName 'TVSUUpdateTask' -TaskPath '\TVT\' -Action $taskAction

if (($($tvTask).Actions | Select-Object -ExpandProperty Arguments) -eq '/CM') {
    exit 0
} else {
    exit 1
}