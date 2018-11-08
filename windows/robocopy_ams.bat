@echo off
REM https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc733145(v=ws.11)

REM Excludes different size, newer files and older files
::robocopy \\vm5\web\ams d:\wamp\www\ams /E /XC /XN /XO

REM Excludes different size and older files
::robocopy \\vm5\web\ams d:\wamp\www\ams /E /XC /XO

REM Mirrors a directory tree (equivalent to /e plus /purge)
::robocopy \\vm5\web\ams d:\wamp\www\ams /MIR

REM Copy Recursively (even empty dir)
robocopy \\vm5\web\ams d:\wamp\www\ams /E
