# http://community.spiceworks.com/topic/674901-need-to-pull-info-for-active-directory
$users = Get-ADUser -Filter { Enabled -eq $true } -Properties StreetAddress, City, 
    State, PostalCode, OfficePhone, MobilePhone | foreach {
    [PSCustomObject]@{
        Name = $_.Name
        Address = $_.StreetAddress
        CityStZip = "$($_.City), $($_.State) $($_.PostalCode)"
        OfficePhone = $_.OfficePhone
        MobilePhone = $_.MobilePhone
    }
}
# Sample outputs
$users | Out-GridView
$users | Export-Csv -Path C:\temp\userlist.csv -NoTypeInformation -Encoding ASCII
$users | Format-List | Out-File -FilePath C:\temp\userlist.txt -Encoding ascii