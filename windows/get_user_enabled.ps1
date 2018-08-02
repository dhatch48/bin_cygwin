Get-ADUser -filter {Enabled -eq $True} –Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed", "PasswordLastSet" |
Select-Object -Property "Displayname","PasswordLastSet",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}} |
sort ExpiryDate |
Export-Csv -NoTypeInformation -Delimiter "`t" D:\Users\david\Documents\user_list.txt
