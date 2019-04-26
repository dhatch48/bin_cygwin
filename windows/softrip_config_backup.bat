@echo off
setlocal

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
	set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
	set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "datestamp=%YYYY%-%MM%-%DD%"

set _source=c:\wwrip70\Configurations\epsonsct3200

set _dest=c:\backup\%datestamp%

set _what=/S /COPYALL
:: /COPYALL :: COPY ALL file info
:: /B :: copy files in Backup mode.
:: /MIR :: MIRror a directory tree

set _options=/R:0 /W:0 /LOG+:C:\backup\RoboLog.txt /NFL /NDL
:: /R:n :: number of Retries
:: /W:n :: Wait time between retries
:: /LOG :: Output log file
:: /NFL :: No file logging
:: /NDL :: No dir logging

robocopy %_source% %_dest%\Configurations\epsonsct3200 %_what% %_options%

robocopy c:\hf_printer-1 %_dest%\hf_printer-1 %_what% %_options% *.cfg
robocopy c:\hf_printer-2 %_dest%\hf_printer-2 %_what% %_options% *.cfg
robocopy c:\hf_printer-3 %_dest%\hf_printer-3 %_what% %_options% *.cfg
robocopy c:\hf_printer-4 %_dest%\hf_printer-4 %_what% %_options% *.cfg
