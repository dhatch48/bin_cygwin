[cmdletbinding()]
param(
  $computerName=$env:COMPUTERNAME,
  [parameter(Mandatory=$true)]
  $processName
)
$processes = Get-WmiObject -Class Win32_Process -ComputerName $computerName -Filter "name='$processName'"
 
$Processes | Select-Object -Property ProcessID,ParentProcessID,@{Label= "UserName"; Expression={$_.GetOwner().User}}, CommandLine |
Sort-Object UserName |
Format-Table -AutoSize