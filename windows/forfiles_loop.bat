@echo off

set sourcePath=.

REM echo/del files older than X number of days
forfiles /p %sourcePath% /s /m *.* /d -365 /c "cmd /c echo @file"
