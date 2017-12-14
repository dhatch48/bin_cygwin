# Setup Hard drive monitoring and email alerts using smartmontools
### Smartd setup for Windows:
1. Download and install smartmontools "Windows package" from
   https://www.smartmontools.org/wiki/Download 
2. Now, navigate the start menu and click smartmontools > smartd Examples >
   Service install, smartd.log, 30min
4. See cmd window open to install service, press enter
5. Click start > smartmontools > smartd Examples > smartd.conf (edit)
6. Comment out line (23) containing "DEVICESCAN" by adding a # at the beginning
7. Go to the very bottom of the file and add your own config like so. Replace
   with correct email address to recieve notification:
    `/dev/sda -m user@gmail.com -M test
    DEVICESCAN -a -o on -S on -s (S/../.././02|L/../../7/04) -m user@gmail.com`
8. Save the file
9. Click start > smartmontools > smartd Examples > smartd_mailer.conf.ps1
   (create, edit)
10. Edit the text file, removing the leading # signs to uncomment and typing
    your correct email settings for:
    `$smtpServer, $from, $port, $useSsl, $username and $password`
11. Save the file
12. Click start > smartmontools > smartd Examples > Service start
13. Now verify config and email: Click start > smartmontools > smartd Examples >
    smartd.log (view)
14. Read the log file and see that it scanned your drives and sent a test email
15. Verify you received the test email to the address used in the smartd.conf
    file
16. Edit the smartd.conf file once more to comment out the test email line:
        `#/dev/sda -m user@gmail.com -M test`
17. Save the file and you're DONE!

For more info on the config or to help fix errors in the log referrence the
manual:
https://www.smartmontools.org/browser/trunk/smartmontools/smartd.8.in 
