Get-NetIPAddress -PrefixOrigin Dhcp -AddressFamily IPv4

$netAdapterIndex = Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | select ifIndex

$defaultGateway =  Get-NetRoute | Where-Object {$_.DestinationPrefix -eq '0.0.0.0/0'} | Select { $_.NextHop } -ExpandProperty NextHop

ping $defaultGateway
ping google.com

Write-Host
if ((Test-Connection $defaultGateway -Count 2 -Quiet) -And (Test-Connection google.com -Count 2 -Quiet)) {
    Write-Host "Connection test to gateway and google passed"
} Else {
    Write-Host "Connection test failed"
}
Read-Host -Prompt "Press Enter to continue"