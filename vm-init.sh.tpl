#!/bin/bash

# Update the list of packages available on the Ubuntu repo
apt-get update

# Install required dependencies
apt-get install -y \
    apache2 \
    php \
    php-mysql \
    php-curl \
    php-json \
    git \
    mysql-client

# Remove default Apache2 webpage
rm -rf /var/www/html/*

# Clone the website repository from GitHub. You can replace the repo URL with yours (created during AppSec part) 
git clone https://github.com/csdso-wavestone/telemetry_cse /tmp/site
cp -R /tmp/site/* /var/www/html/

# Setting up Apache2 and restart it
chown -R www-data:www-data /var/www/html
systemctl restart apache2

# MySQL configuration
MYSQL_HOST="${nickname}sqlservercse.mysql.database.azure.com"
MYSQL_USER="adminformation"
MYSQL_PASSWORD="formationCodingGame0!"

# Wait until MySQL is available
while ! mysql \
    -h "$MYSQL_HOST" \
    -u "$MYSQL_USER" \
    -p"$MYSQL_PASSWORD" \
    -e "SELECT 1" >/dev/null 2>&1
do
    sleep 10
done

# Initialize database
mysql \
    -h "$MYSQL_HOST" \
    -u "$MYSQL_USER" \
    -p"$MYSQL_PASSWORD" \
    < /tmp/site/sql.sql

# Replace hardcoded database credentials in PHP source code
# by environment variables read at runtime
sed -i "s|\$db_user = .*;|\$db_user = getenv('DB_USER');|g" /var/www/html/mysqli_connect.php
sed -i "s|\$db_password = .*;|\$db_password = getenv('DB_PASSWORD');|g" /var/www/html/mysqli_connect.php
sed -i "s|\$db_host = .*;|\$db_host = getenv('DB_HOST');|g" /var/www/html/mysqli_connect.php

# Add database connection settings to Apache environment variables
cat << EOF >> /etc/apache2/envvars
export DB_USER=$${MYSQL_USER}
export DB_PASSWORD=$${MYSQL_PASSWORD}
export DB_HOST=$${MYSQL_HOST}
EOF

# Set ownership of the uploads directory
chown daemon /var/www/html/uploads

# Restart Apache to apply configuration changes
systemctl restart apache2