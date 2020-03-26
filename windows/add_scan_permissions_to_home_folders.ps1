<#
.SYNOPSIS
   Fix permissions so that users can scan to their home folder
.DESCRIPTION
   Loop over each user's home folder and add modify permission for account "mpscansvc".
   This adds permission to the user's home folder only.
.NOTES
    Author: David Hatch
    This can be added to a scheduled task to automate.
#>

$sourceFolder = "C:\Users\dhatc\Downloads\temp"

Foreach ($folder in Get-ChildItem -Path $sourceFolder -Directory) {

    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("safety\mpscansvc","Modify","Allow")
    $acl = Get-Acl $folder.FullName
    $acl.SetAccessRule($accessRule)
    Set-Acl -Path $folder.FullName -AclObject $acl
    #get-acl $folder.FullName | fl
}