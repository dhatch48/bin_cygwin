<#
.SYNOPSIS
    Script to fix ethernet adapter showing "No Internet" Status
.DESCRIPTION
    Disables checksum offloading on all ethernet adapters targeted by $interfaceSearch
.EXAMPLE
    disable_checksum_offload.ps1 -silent
    Disable all checksum offloading and don't show output
.EXAMPLE
    disable_checksum_offload -ipv6
    Disable only for IPv6
.EXAMPLE
    disable_checksum_offload -enable
    Enable all checksum offloading
.LINK
    https://community.spiceworks.com/topic/2130619-no-internet-access-but-there-is
    https://docs.microsoft.com/en-us/powershell/module/netadapter/disable-netadapterchecksumoffload?view=win10-ps
.NOTES
    Author: David Hatch
#>

Param (
    [switch]$enable,
    [switch]$ipv6,
    [switch]$silent
)

# Target only MDT dock/keyboard ethernet ports
$interfaceSearch = "Realtek*"

if (! $silent) {
    # Show targeted adapters
    Get-NetAdapter -InterfaceDescription $interfaceSearch | Select-Object Name,InterfaceDescription,Status,DriverVersion
}

if ($ipv6) {
    # Disable only IPv6 checksum offloading
    Disable-NetAdapterChecksumOffload -InterfaceDescription $interfaceSearch -TcpIPv6 -UdpIPv6

    # Disable only IPv6 LSO
    Disable-NetAdapterLso -InterfaceDescription $interfaceSearch -IPv6

} elseif ($enable) {
    # Enable all checksum offloading
    Enable-NetAdapterChecksumOffload -InterfaceDescription $interfaceSearch
    if ($?) {
        Remove-Item C:\SMSCache\internetaccess.txt -ErrorAction SilentlyContinue
    }

    # Enable all LSO
    Enable-NetAdapterLso -InterfaceDescription $interfaceSearch

} else {
    # Disable all checksum offloading. This also causes RSS, RSC and LSO to be disabled
    Disable-NetAdapterChecksumOffload -InterfaceDescription $interfaceSearch
    if ($?) {
        echo Done! > C:\SMSCache\internetaccess.txt
    }
}

if (! $silent) {
    # Show the current settings
    Get-NetAdapterChecksumOffload -InterfaceDescription $interfaceSearch | ft
    Get-NetAdapterLso -InterfaceDescription $interfaceSearch | ft
}

exit 0