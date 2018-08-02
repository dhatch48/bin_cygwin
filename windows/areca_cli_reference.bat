@echo off
set PATH=%PATH%;"C:\Program Files (x86)\MRAID\CLI\"

REM list commands
::cli ctrl=10.93.0.202 main

cli ctrl=10.93.0.202 sys info
cli ctrl=10.93.0.202 rsf info
cli ctrl=10.93.0.202 vsf info
::cli ctrl=10.93.0.202 disk info drv=21

REM Some commands require password. Use this line to avoid "Passord Required" error
::cli ctrl=10.93.0.202 set password=0000
::cli ctrl=10.93.0.202 sys showcfg

REM Set the background task priority
::cli ctrl=10.93.0.202 sys changept p=2
::cli ctrl=10.93.0.202 sys showcfg

REM save backup config to file
::cli ctrl=10.93.0.202 set password=0000
::cli ctrl=10.93.0.202 sys savebin path=d:\Users\david\Downloads\arc-1882_config.bin
::cli ctrl=10.93.0.201 set password=0000
::cli ctrl=10.93.0.201 sys savebin path=d:\Users\david\Downloads\arc-1880_config.bin

REM check volume command
::cli ctrl=10.93.0.202 set password=0000
::cli ctrl=10.93.0.202 vsf check vol=1
::cli ctrl=10.93.0.202 vsf stopcheck
