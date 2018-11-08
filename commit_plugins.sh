#!/bin/bash
#set -x

pluginDir="$HOME/public_html/wp-content/plugins"
inputFile=${1:-$HOME/bin/plugin.csv}
properName=''

while IFS= read -r line; do
    ### Filter out non plugin updates
    properName=$(awk -F, '$5~/Plugin/ && $6~/Update/ {print $7}' <<< "$line" | sed 's/"//g')
    [[ -z $properName ]] && continue

    version=$(awk -F, '{gsub(/ - /, " => ", $8); print $8}' <<< "$line" | sed 's/"//g')
    #fileMatch=$(cd "$pluginDir"; grep -r "Plugin Name:[ \t]*$properName[ \t\r\n\f]*$" . )
    fileMatch=$(cd "$pluginDir"; grep -Pr "Plugin Name:\s*$properName\s*\r*$" . )
    if [[ -z $fileMatch ]]; then
        echo -e "No match found for:\t$properName"
        continue
    fi
    folderName=$(awk -F/ '{print $2}' <<< "$fileMatch" | head -n 1)

    cd "$pluginDir"
    git add "./$folderName"
    git commit -m "Plugin - Updates $properName from version $version" >/dev/null; status=$?
    if [[ $status == 0 ]];then
        echo "Success: $properName"
    else
        echo "Error: Commit failed for $properName"
    fi

done < "$inputFile"
