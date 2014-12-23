#!/bin/bash

# Expects one or more arguments of file paths
# Outputs created date in UTC and filename tab seperated for each file
for file in "$@"; do
    date=$(date -u -d @$(stat -c '%W' "$file") '+%Y-%m-%d %H:%M:%S')
    printf "$date\t$file\n"
done
