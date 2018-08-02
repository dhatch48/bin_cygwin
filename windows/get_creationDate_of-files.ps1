#Get-ItemProperty -Path D:\Users\david\Documents\user_expiration.txt | Format-list -Property * -Force

Get-ChildItem -Path W:\unified\data\orderSubmission\ |
Select-Object @{Name="CreationDate"; Expression={$_.CreationTimeUtc.ToString("yyyy-MM-dd HH:mm:ss")}}, Name |
sort CreationDate |
Export-Csv -NoTypeInformation -Delimiter "`t" D:\Users\david\Documents\uploadsDirList.txt