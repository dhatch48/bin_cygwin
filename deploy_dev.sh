#!/bin/bash
### Requires WP-CLI v1.3.0

if [[ $USER != devhonorlife ]]; then
    echo "Error: This script must only be run as devhonorlife user."
    exit 1
fi

sourceDir='/home/honorlife/public_html'
destDir='/home/devhonorlife/public_html'

### Delete existing files in $destDir
read -p "Deleting all files in $destDir ...Continue? (y/n): " -n 1 -r
echo
if [[ $REPLY = [yY] ]]; then
    rm -rf "$destDir/".[!.]* "$destDir/"*
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
#cp -R "$sourceDir/"* "$destDir"
git clone git@github.com:rayzistdev/honorlife-wp.git "$destDir"
cp "$HOME/bin/.htaccess" "$destDir"
cp "$sourceDir/.user.ini" "$destDir"
sed -i 's/honorlife/devhonorlife/' "$destDir/.user.ini"
cp -R "$sourceDir/wp-content/uploads" "$destDir/wp-content/"
echo "Source files transfered"

### Create wp-config.php
rm -f "$destDir/wp-config.php"
wp config create \
    --dbname=devhonor_hl --dbuser=devhonor_dev --dbpass=d^E.Sp.zrF1Q --dbhost=localhost --dbprefix=hlwp_ --extra-php <<EOL
@ini_set('display_errors', 'On');
@ini_set('log_errors', 'On');
@ini_set('error_log', '/home/devhonorlife/logs/php_error.log');
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', true);
define('SAVEQUERIES', false);
define('WP_MEMORY_LIMIT', '1024M');
define('WP_POST_REVISIONS', 10);
EOL

### Clone DB and update site name
echo "Starting clone of Database"
cd "$destDir"
wp db export prod.sql --path="$sourceDir"
wp db reset --yes
wp db import prod.sql && rm -f prod.sql

wp option update siteurl https://dev.honorlife.com
wp option update home https://dev.honorlife.com
wp option update blogname 'Honor Life Dev'

echo "Searching and replacing domain name. Please wait this takes several minutes"
wp search-replace 'www.honorlife.com' 'dev.honorlife.com' 'hlwp_posts'
wp rewrite flush

### Disable plugins
wp plugin deactivate w3-total-cache
wp plugin deactivate clicky
wp plugin deactivate stream
wp plugin deactivate wordfence
wp plugin deactivate livechat-woocommerce

echo "Done"
exit 0
