#!/bin/bash

sort -nr -t, -k31,31 "$1" | gawk -f ./verizon_message_usage.awk

gawk '
BEGIN { 
    FPAT = "([^,]*)|(\"[^\"]+\")";
    OFS = ",";
}
$31+$32+$39+$40 > 30 && 
$4 != "TRACY RITZER" && $4 != "LEE HENDERSON" && $4 != "JOE STEPHENSON" { 
    print $1,$4,$31,$32,$39,$40,$31+$32+$39+$40
}
' "$1" | sort -nr -t, -k7,7 > verizon_message_usage.csv
