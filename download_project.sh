#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: Missing argument. Please specify what directory to download"
    exit 1
fi

cd H:/PROJECTS/KMI

### Download or update files except for solid works files
if wget -r -N -np -nH -R "*.SLD???" --ignore-case --user=KMI-Columbaria --ask-password "ftp://files.qminx.com/$1"; then
    cd "./$1"
    echo
    echo "Project files successfully downloaded or updated here:"
    pwd
    ### Reset file permissions for this folder
    cygstart --action=runas icacls "\"$(cygpath -wa .)\" /reset /t /c /q"
fi
