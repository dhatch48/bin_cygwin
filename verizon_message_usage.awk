BEGIN { 
    FPAT = "([^,]*)|(\"[^\"]+\")";
    OFS = ",";
    print;
    print "Current message usage greator than 60";
    # New Header Row
    printf "%-14s %-15s %-7s %-8s %-7s %-8s %-7s\n","Wireless #","User name","TXT rec","TXT sent","PIX rec","PIX sent", "Total"
}
# Header Row
#NR==19 {
    #printf "%-14s %-15s %-7s %-8s %-7s %-8s\n", $1,$4,$31,$32,$39,$40
#}
$31+$32+$39+$40 > 30 && 
$4 != "TRACY RITZER" && $4 != "LEE HENDERSON" && $4 != "JOE STEPHENSON" { 
    printf "%-14s %-15s %-7d %-8d %-7d %-8d %-7d\n", $1,$4,$31,$32,$39,$40,$31+$32+$39+$40
}
