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
export MYSQL_HOST="${nickname}sqlservercse.mysql.database.azure.com"
export MYSQL_USER="adminformation"
export MYSQL_PASSWORD="formationCodingGame0!"

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