#!/usr/bin/env bash

set -eo pipefail    # Turns on strict error options - exit on first error.

#/ Usage: find_in_zip.sh [OPTION] PATTERN FILE
#/ Description: Looks in zip archive(s) for files that match the given string.  Outputs all matches and the current archive file name.
#/ Examples: find_in_zip.sh 'name.jpg' /path/to/zip/files/*.zip
#/ Options:
#/      -h: Display this help message
#/      -d: debug mode
#/      -F: match literal "Fixed" string instead of regex. Uses grep -F
#/      -q: surpress matches and only output archive file name

# Basic helpers
out() { echo "$(date '+%Y-%m-%d %H:%M:%S') $@"; }
err() { out "[ERROR] $@" 1>&2; echo; }
die() { out "[FATAL] $1" && [ "$2" ] && [ "$2" -ge 0 ] && exit "$2" || exit 1; }
usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
opt='--color=auto'

while getopts "Fdhq" o; do
    case "$o" in
        d) DEBUG=1 ;;
        h) usage ;;
        F) opt+=' -F' ;;
        q) opt+=' -q' ;;
    esac
done
shift $((OPTIND-1))


[ "$DEBUG" ] && set -x
# Script start
###############################################################################

if [[ $# -ge 2 ]]; then
    file="$1"
    shift
    for i in "$@"; do 
        if [[ -f $i && $i = *.zip ]]; then
            grep $opt "$file" < <(unzip -l "$i") && echo "$i"
        else
            err "Incorrect file given: $i"
        fi
    done
else
    usage
fi
exit 0
