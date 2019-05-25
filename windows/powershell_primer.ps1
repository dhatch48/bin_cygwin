# Allow local created scripts to run and remote scripts if they are signed
#Set-ExecutionPolicy RemoteSigned

echo "Get help for a command"
ls -?

echo ""
echo ""
echo "Get detailed help for a command"
Get-help ls -detailed

echo ""
echo ""
echo "Use Get-Member to show all methods and properties"
$myDate = Get-Date
$myDate | Get-Member | Format-Table

echo ""
echo "Or list only the properties"
$myDate | Select-Object -Property *

# Get and kill process named notepad
#Get-Process -Name notepad | Kill

#or just kill all that start with notepad
#kill -Name notepad*
