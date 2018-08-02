@echo off
set PATH=%PATH%;"C:\Program Files (x86)\MRAID\CLI\"

REM check volume command
cli ctrl=10.93.0.201 set password=0000
cli ctrl=10.93.0.201 sys changept p=2
cli ctrl=10.93.0.201 vsf check vol=1
REM stop check
::cli ctrl=10.93.0.201 vsf stopcheck
