@echo off
set PATH=%PATH%;"C:\Program Files (x86)\MRAID\CLI\"

REM check volume on 1st array
cli ctrl=10.93.0.201 set password=0000
cli ctrl=10.93.0.201 sys changept p=2
cli ctrl=10.93.0.201 vsf check vol=1

REM check volume on 2nd array
cli ctrl=10.93.0.202 set password=0000
cli ctrl=10.93.0.202 sys changept p=2
cli ctrl=10.93.0.202 vsf check vol=1
