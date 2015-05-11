#!/bin/bash

# Get totals from csv time tracker app
# @param year in 2 digit format
# @param file path to total

year="$1"
file="$2"
usage="usage: $0 year file
year is in 2 digit format"

if [ -n "$year" -a -n "$file" ]; then
    awk -F'\"' 'BEGIN {OFS="\n"} $4 ~ /\/'"$year"' / { SUM += $12 + 0 } END { print "20'"$year"' Total Earnings:",SUM }' "$file"
else
    echo "$usage"
    exit 1
fi
