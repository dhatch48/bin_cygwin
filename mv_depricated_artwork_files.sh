#!/bin/bash
#set -x

fileList='/cygdrive/w/unified/data/artwork/layouts/deprecated_list.txt'
basePath='/cygdrive/w/unified/data/artwork/layouts'
currentPath="$basePath/$1"
newPath="$currentPath/Deprecated/"
totalFileCount=$(wc -l "$fileList" | awk '{print $1}')

if [[ ! -d $currentPath ]]; then
    echo "$currentPath isn't a valid directory"
    exit 1
fi

if [[ ! -d $newPath ]]; then
    mkdir $newPath
fi

count=0
while IFS= read -r file; do
    mv "$currentPath/$file" "$newPath"
    rc=$?
    if [[ $rc == 0 ]];then
        ((count++))
        echo "moved: $file"
    fi
done < "$fileList"
echo "$count out of $totalFileCount files moved"
