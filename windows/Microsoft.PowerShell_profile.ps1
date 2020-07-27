# Create PS profile file
#New-Item -path $profile -type file -Force

# Don't save commands that start with space
function Check-HistoryCommand($command) {
    if ($command -like ' *') {
        return $false
    }
    return $true
}

Set-PSReadLineOption -AddToHistoryHandler (Get-Item Function:Check-HistoryCommand).ScriptBlock

# Set PSReadline Options and bindings
if (get-command Set-PSReadlineKeyHandler -errorAction SilentlyContinue) {
    Set-PSReadlineOption -EditMode vi -BellStyle None -ViModeIndicator Prompt
    Set-PSReadlineKeyHandler -ViMode Insert -Chord Ctrl+d -Function DeleteCharOrExit
    Set-PSReadLineKeyHandler -ViMode Insert -Chord UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -ViMode Insert -Chord DownArrow -Function HistorySearchForward
}

# Use less instead of more
if (get-command less.exe -errorAction SilentlyContinue) {
    Set-Alias more less.exe
    # for PS core
    $env:PAGER = 'less.exe'
}

function Get-Path {
    $env:Path.Split(";")
}
new-alias path Get-Path

function elevate-cmd {
    Start-Process @args -verb runas
}
new-alias sudo elevate-cmd

function down {
    cd $HOME\Downloads
}

function nu {
    net user /domain $args
}

function nu-reset {
    net user $args Police123 /logonpasswordchg:yes /active:yes /domain
}

function find-adcomputer {
    get-adcomputer -Filter "description -like `"*$args*`"" -Properties description,IPv4Address
}
new-alias fac find-adcomputer

function get-uninstallString {
    Param(
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$true)]
        [String]
        $searchName
    )
    Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall |
        Get-ItemProperty | Where-Object {$_.DisplayName -match "$searchName" } |
        Format-List -Property DisplayName, DisplayVersion, UninstallString, PSPath
}

function install-powershell {
    Invoke-Expression "& { $(Invoke-RestMethod https://aka.ms/install-powershell.ps1) } -UseMSI"
}

# Welcome
"Welcome {0}, to Powershell {1}" -f $ENV:username,($PSVersionTable.PSVersion)
"Today is {0:F}`n" -f (get-date)
