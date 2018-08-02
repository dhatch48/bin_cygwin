#Get-WmiObject -Namespace root\MicrosoftDNS -List -ComputerName dc4
Get-WmiObject -Namespace Root\MicrosoftDNS -Query "SELECT * FROM MicrosoftDNS_AType WHERE ContainerName='dottek.com'" -ComputerName dc4 |
Select-Object -Property "OwnerName", "IPAddress" |
#Export-Csv -NoTypeInformation -Delimiter "`t" D:\Users\david\Documents\dnsEntries.txt
Out-File -Encoding ascii -FilePath \\dc4\c$\dnsEntries.txt