#!/bin/bash

shopt -s expand_aliases
alias wp=~/bin/wp-cli.phar

wp --version

sourceDir=~/public_html
destDir=~/public_html/test/

### Delete existing files in $destDir
read -p "Deleting all files in $destDir ...Continue? (y/n): " -n 1 -r
echo
if [[ $REPLY = [yY] ]]; then
    rm -rf "$destDir"
    mkdir "$destDir"
    if [[ -z $(ls -A "$destDir") ]]; then
        echo "Destination cleaned"
    else
        echo "Error: destination not empty"
        exit 2
    fi
else
    echo "Script aborted by user"
    exit 0
fi


### Clone source files
echo "Starting clone of source files"
cp "$sourceDir/"* "$destDir"
cp "$HOME/bin/.htaccess" "$destDir"
cp -R "$sourceDir/wp-"* "$destDir"
echo "Source files transfered"

### Create wp-config.php
cd "$destDir"
rm ./wp-config.php
wp config create \
    --dbname=test_yoursite --dbuser=test_user --dbpass='yoursitePass' --dbprefix=wp_ --extra-php <<EOL
@ini_set('display_errors', 'Off');
@ini_set('log_errors', 'On');
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);
define('SAVEQUERIES', false);
define('WP_POST_REVISIONS', 10);
define('WP_MEMORY_LIMIT', '128M');
define('WP_AUTO_UPDATE_CORE', 'minor');
EOL

### Clone DB and update site name
echo "Starting clone of Database"
cd "$destDir"
wp db export prod.sql --path="$sourceDir"
wp db reset --yes
wp db import prod.sql && rm -f prod.sql

wp option update siteurl 'http://test.yoursite.com'
wp option update home 'http://test.yoursite.com'
wp option update blogname 'Yoursite TEST'

echo "Searching and replacing domain name. Please wait this takes several minutes"
wp search-replace 'yoursite.com' 'test.yoursite.com' 'wp_posts'
wp rewrite flush

### Disable plugins
wp plugin deactivate w3-total-cache
wp plugin deactivate wordfence
wp plugin deactivate wp-live-chat-software-for-wordpress

echo "Done"
exit 0
