REM Time Providers: 0.us.pool.ntp.org 1.us.pool.ntp.org 2.us.pool.ntp.org 3.us.pool.ntp.org

REM Check which server is PDC
netdom /query fsmo

REM Run this on PDC
w32tm /config /syncfromflags:manual /manualpeerlist:"0.us.pool.ntp.org 1.us.pool.ntp.org 2.us.pool.ntp.org 3.us.pool.ntp.org" /reliable:yes /update
net stop w32time && net start w32time
w32tm /resync

REM Run this on all other DCs
w32tm /config /syncfromflags:domhier /update
net stop w32time && net start w32time
w32tm /resync

REM See status
w32tm /query /status /verbose

REM See Config
w32tm /query /configuration

REM See time difference between ntp server and local server
w32tm /stripchart /computer:0.us.pool.ntp.org /samples:5 /dataonly