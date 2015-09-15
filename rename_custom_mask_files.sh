#!/bin/bash
logFile='/tmp/renamed_files.txt'

if [[ -d $1 ]]; then
    date >> "$logFile"

    files="$(find "$1" -name '12345 *')"
    IFS=$'\n'
    for file in $files; do
        orderId="${file%%/12345*}"
        orderId="${orderId##*/}"
        if (( ${#orderId} == 5 )); then
            mv -v "$file" "${file/12345/$orderId}" >> /tmp/renamed_files.txt
        else
            echo >> "$logFile"
            echo -e "Error: orderId not found.\nCurrent file is: $file" && exit 2
        fi
    done
    echo >> "$logFile"
    echo "Done"
else
    echo "Error: Param 1 not a valid path" && exit 1
fi
