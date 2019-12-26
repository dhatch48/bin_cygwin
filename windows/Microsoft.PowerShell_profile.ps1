# Create PS profile file
#New-Item -path $profile -type file

# Use less instead of more
if (get-command less.exe -errorAction SilentlyContinue) {
    Set-Alias more less.exe
}

# Exit with ctrl+d
if (get-command Set-PSReadlineKeyHandler -errorAction SilentlyContinue) {
    Set-PSReadlineKeyHandler -Chord Ctrl+d -Function DeleteCharOrExit
}

function Get-Path {
	$env:Path.Split(";")
}
new-alias path Get-Path

function elevate-cmd {
	start "$args" -verb runas
}
new-alias sudo elevate-cmd

function down {
	cd $HOME\Downloads
}

# Welcome
"Welcome {0}, to Powershell {1}" -f $ENV:username,($PSVersionTable.PSVersion)
"Today is {0:F}`n" -f (get-date)
