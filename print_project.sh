#!/usr/bin/env bash

set -eo pipefail    # Turns on strict error options - exit on first error.

#/ Usage: printProj.sh [OPTION] FILE
#/ Description:
#/ Examples: printProj.sh PROJECTNAME
#/ Options:
#/      -h: Display this help message
#/      -d: debug mode
#/      $1: project name

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

[ -z "$1" ] && usage

myprint=/cygdrive/d/Temp/print/
cd /cygdrive/h/PROJECTS/KMI/"$1"/

### Clean temp print folder
rm -f "$myprint"*

### Filter out duplicates and granite trim files
cp "$1.PDF" "$myprint"
cp -n KMI-*/*.PDF EXTRA-SHEETMETAL/*.PDF "$myprint"

### Print the files
for file in $myprint/*; do
    #echo "Printing: $(cygpath -aw $file)"
    pdftoprinter.exe "$(cygpath -aw $file)" "Copier_2nd_Floor_PCL"
done
