# Target only MDT dock/keyboard ethernet ports
$interfaceSearch = "Realtek*"

# Get netadapter checksum offload settings
$myInterfaces = Get-NetAdapterChecksumOffload -InterfaceDescription $interfaceSearch
foreach ($i in $myInterfaces) {
    if ($i.IpIPv4Enabled -ne "Disabled") {
        # Checksum offload is enabled
        Write-Output "not-compliant"
        exit
    }
}

# Config is correct. Checksum offload is disabled on all adapters
Write-Output "compliant"