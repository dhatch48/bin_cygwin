#!/bin/bash
#set -x

# Justin-pc mac
MAC=${1:-'4c:72:b9:21:80:14'}
Broadcast=${2:-'255.255.255.255'}
PortNumber=${3:-9}

echo -e $(echo $(printf 'f%.0s' {1..12}; printf "$(echo $MAC | sed 's/:\|-//g')%.0s" {1..16}) | sed -e 's/../\\x&/g') | nc -w1 -u $Broadcast $PortNumber
