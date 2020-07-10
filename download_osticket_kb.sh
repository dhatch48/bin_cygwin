#!/usr/bin/env bash

set -eo pipefail    # Turns on strict error options - exit on first error.

#/ Usage: download_osticket_kb.sh [OPTION] FILE
#/ Description: Download all KB articles and organize by category from provided list
#/ Examples: download_osticket_kb.sh kb_list.txt
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

dest=~/tmp/

while IFS="" read -r line || [ -n "$line" ]; do
    # Extract fileId and categoryName from tab delimited file

    # Takes 4 seconds using awk
    #fileID=$(awk -F '\t' '{print $1}' <<<"$line")
    #categoryName=$(awk -F '\t' '{print $3}' <<<"$line")

    # Takes 3 seconds using cut
    #fileID=$(cut -d'	' -f1 <<<"$line")
    #categoryName=$(cut -d'	' -f3 <<<"$line")

    # Takes 0 seconds using parameter expansion
    fileID="${line%%	*}"
    categoryName="${line##*	}"

    # Create categories as subfolders
    cd "$dest"
    if [ ! -d "$dest$categoryName" ]; then
        mkdir "$dest$categoryName";
    fi
    cd "$dest$categoryName"

    # Download KBs and save with remote header name
    curl "https://osticket01v.safety.ci.carlsbad.ca.us/scp/faq.php?id=$fileID&a=print" \
      -H 'pragma: no-cache' \
      -H 'cache-control: no-cache' \
      -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36 Edg/83.0.478.58' \
      -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
      -H 'accept-language: en-US,en;q=0.9' \
      -H 'cookie: OSTSESSID=usnr53v9unc0vgnb7m1susaafg' \
      -O -J --insecure
done < "$1"

exit 0
