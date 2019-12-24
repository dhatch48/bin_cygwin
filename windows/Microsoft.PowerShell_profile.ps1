# Use less instead of more
Set-Alias more less.exe

# Exit with ctrl+d
Set-PSReadlineKeyHandler -Chord Ctrl+d -Function DeleteCharOrExit

function Get-Path {
	$env:Path.Split(";")
}
new-alias path Get-Path

function elevate-cmd {
	start "$args" -verb runas
}
new-alias sudo elevate-cmd

# Welcome
"Welcome {0}, to Powershell {1}" -f $ENV:username,($PSVersionTable.PSVersion)
"Today is {0:F}`n" -f (get-date)
