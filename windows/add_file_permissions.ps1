$items = Get-ChildItem D:\Users\david\Documents\mytest | ?{ $_.PSIsContainer }
$items | foreach {
    #<#
    $acl = Get-Acl $_.FullName
    $permission = "dottek\I-dev group","Modify",'ContainerInherit,ObjectInherit','None',"Allow"
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
    $acl.SetAccessRule($accessRule)
    $acl | Set-Acl $_.FullName
    #>
    echo "Processed: $($_.FullName)"
}
