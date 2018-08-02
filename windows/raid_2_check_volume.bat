@echo off
set PATH=%PATH%;"C:\Program Files (x86)\MRAID\CLI\"

REM check volume command
cli ctrl=10.93.0.202 set password=0000
cli ctrl=10.93.0.202 sys changept p=2
cli ctrl=10.93.0.202 vsf check vol=1
REM stop check
::cli ctrl=10.93.0.202 vsf stopcheck
