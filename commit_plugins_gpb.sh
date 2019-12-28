#!/bin/bash
#set -x

### Create inputFile with wp cli command shown here:
# wp plugin update --all --format=csv > ~/bin/plugin.csv
###

shopt -s expand_aliases
alias wp=~/bin/wp-cli.phar

pluginDir="$HOME/public_html/wp-content/plugins"
inputFile=${1:-$HOME/bin/plugin.csv}

while IFS= read -r line; do
    pluginName=$(awk -F, '{print $1}' <<< "$line")
    if [ "$pluginName" = "name" ]; then
        continue
    fi

    oldVersion=$(awk -F, '{print $2}' <<< "$line")
    newVersion=$(awk -F, '{print $3}' <<< "$line")
    pluginTitle=$(cd "$pluginDir"; wp plugin get $pluginName --fields=title --format=csv | tail -1 | cut -d',' -f2)

    cd "$pluginDir"
    git add "./$pluginName"
    git commit -m "Plugin - Updates $pluginTitle from version $oldVersion => $newVersion" >/dev/null; status=$?
    if [[ $status == 0 ]];then
        echo "Success: $pluginName"
    else
        echo "Error: Commit failed for $pluginName"
    fi

done < "$inputFile"
