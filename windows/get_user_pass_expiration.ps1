Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False} –Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed", "PasswordLastSet" |
Select-Object -Property "Displayname","PasswordLastSet",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}} |
sort ExpiryDate |
Export-Csv -NoTypeInformation -Delimiter "`t" D:\Users\david\Documents\user_expiration.txt
# Old way
#Out-File -Encoding ascii -FilePath D:\Users\david\Documents\user_expiration.txt