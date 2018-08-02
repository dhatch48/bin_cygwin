$Host.UI.RawUI.BufferSize = New-Object Management.Automation.Host.Size (500, 1000)
$filePath = "$env:USERPROFILE\Desktop\close_sage.log"
$timestamp = Get-Date
$systems = @('reception-pc', 'shipping2-pc', 'david-pc', 'edelia-pc', 'kathy-pc', 'vm7')

### Main Loop - Close sage on each system
Add-Content $filePath "$timestamp"
foreach ($hostName in $systems) {

    ### Skip if host is not alive
    $result = Test-Connection -Count 1 -Quiet $hostName
    if($result -eq $false) {
        continue
    }

    ### Get processes
    $processes = Get-WmiObject -Class Win32_Process -ComputerName $hostName -Filter "name='pvxwin32.exe'"

    ### Log processes found
    $Processes | Select-Object -Property CSName, ProcessID, SessionId, @{Label= "UserName"; Expression={$_.GetOwner().User}},@{ Label = "RunTime"; Expression={(get-date) - $_.ConvertToDateTime($_.CreationDate)}}, CommandLine |
    Sort-Object UserName |
    Format-Table -AutoSize |
    Out-File $filePath -Append ascii

    ### Terminate processes found. Kill launcher window last.
    foreach ($process in ($processes | Sort-Object CommandLine)) {
        $processId = $process.ProcessID
        $returnVal = $process.terminate()
        if($returnVal.returnvalue -eq 0) {
            Add-Content $filePath "Process $processId terminated successfully"
        }
        else {
            Add-Content $filePath "Process $processId terminated with code $returnVal"
        }
    }
}
Add-Content $filePath "Done`r`n`r`n`r`n"