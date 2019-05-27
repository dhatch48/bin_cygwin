# Allow local created scripts to run and remote scripts if they are signed
#Set-ExecutionPolicy RemoteSigned

echo "Find the command you want"
Get-Command -Name *service*

echo ""
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
#Get-Process -Name notepad | Stop-Process

# or just kill all that start with notepad
#kill -Name notepad*

# Get and stop a service
#Get-Service "bonjour service" | Stop-Service

# Test connectivity to multiple computers once (ping)
#Test-Connection -ComputerName Server01, itadmin01v, dt0101 -count 1

# Test if remote port is open (tnc for short)
#Test-NetConnection 192.168.1.21 -Port 3389
