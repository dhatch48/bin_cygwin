Add-PSSnapin VMware.VimAutomation.Core | Out-Null
$ESXiHost1 = “10.93.0.37"
$ESXiUser = “root”
$ESXiPassword = “Qsym0oq4”
Connect-VIServer $ESXiHost1 –User $ESXiUser –Password $ESXiPassword | Out-Null
Get-VMHostStorage $ESXiHost1 –RescanAllHba
Disconnect-VIServer $ESXiHost1 –Confirm:$false