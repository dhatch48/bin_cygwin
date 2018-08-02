@echo off

forfiles /p Z:\mysql\mysql\ /s /m *.sql /d -60 /c "cmd /c del @path"