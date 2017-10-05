#!/bin/bash
#set -x

siteUrl=${1:-'http://10.93.0.6/server-status'}
timeout=60

### Get all W state requests
result=$(lynx -dump -width 1024 "$siteUrl")
wStates=$(awk '/W [1-9][0-9]+/ {print $0}' <<< "$result")
### Alternate method. Gets raw html
#VAR=$(wget --quiet -O - http://127.0.0.1/server-status)


#$4,$5,$10,$12,$13
### Get greatest time of W state requests
if [[ -n $wStates ]]; then
    greatestTime=$(awk 'BEGIN{n=0} {if($5>n) n=$5} END{print n}' <<< "$wStates")
    if [[ $greatestTime -gt $timeout ]]; then
        #message="This is a test."
        #email -o -s "Warning: Apache Status Critical" dhatch@rayzist.com <<< "$message"
        echo $greatestTime
        exit 1
    fi
fi
exit 0
