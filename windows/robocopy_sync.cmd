@echo off
SETLOCAL EnableExtensions
set myComputer=FDX-5CG1103QJS
set oneDrivePath="C:\Users\4103847\OneDrive - MyFedEx\Documents\customers\\"

If "%computername%"=="%myComputer%" goto :sync
color 04
echo "Not %myComputer%!"
goto :done

:to
echo Syncing to One Drive...
robocopy .\customers\ %oneDrivePath% /E /XO
goto :eof

:from
echo Syncing from One Drive...
robocopy %oneDrivePath% .\customers\ /E /XO
goto :eof

:dry
echo Dry run....
echo Syncing to One Drive...
robocopy .\customers\ %oneDrivePath% /E /XO /L

echo Dry run....
echo Syncing from One Drive...
robocopy %oneDrivePath% .\customers\ /E /XO /L
goto :eof

:sync
color 02
set /P c=Sync TO or FROM One Drive or BOTH or DRY Run [T/F/B/D/N]?
if /I "%c%" EQU "T" (
    call :to
    goto :done
)
if /I "%c%" EQU "F" (
    call :from
    goto :done
)
if /I "%c%" EQU "B" (
    call :to
    call :from
    goto :done
)
if /I "%c%" EQU "D" (
    call :dry
    goto :done
)
if /I not "%c%" EQU "N" goto :sync
echo No Sync

:done
echo Done!
pause
