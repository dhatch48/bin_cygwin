#!/usr/bin/env bash

set -eo pipefail    # Turns on strict error options - exit on first error.

#/ Usage: save_win10_backgrounds.sh [OPTION]
#/ Description: Saves all windows 10 backgrounds to my pictures. Only saves the images that are 1920x1080 resolution and renames with .jpg extension.
#/ Examples: 
#/ Options:
#/      -h: Display this help message
#/      -d: debug mode

# Basic helpers
out() { echo "$(date '+%Y-%m-%d %H:%M:%S') $@"; }
err() { out "[ERROR] $@" 1>&2; echo; }
die() { out "[FATAL] $1" && [ "$2" ] && [ "$2" -ge 0 ] && exit "$2" || exit 1; }
usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }

# Parse options
while getopts "dh" opt; do
    case "$opt" in
        d) DEBUG=1 ;;
        h) usage ;;
    esac
done
shift $((OPTIND-1))

[ "$DEBUG" ] && set -x
# Script start
###############################################################################

sourceDir=$(cygpath -u 'C:\Users\dhatch\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\')
destDir='/cygdrive/e/Pics/win10_backgrounds/'

# Only copy the full size backgrounds
for file in $(find "$sourceDir" -size +300k); do
    res=$(file --brief "$file" | awk -F', ' '{ print $(NF-1) }')
    if [ $res == '1920x1080' ];then
        cp -n "$file" "$destDir${file##*/}.jpg"
        echo "copied file: $destDir${file##*/}.jpg"
    fi
done
