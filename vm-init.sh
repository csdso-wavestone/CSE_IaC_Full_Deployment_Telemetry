#!/bin/bash

apt-get update

apt-get install -y \
    apache2 \
    php \
    php-mysql \
    git

rm -rf /var/www/html/*

git clone https://github.com/csdso-wavestone/telemetry_cse /tmp/site

cp -R /tmp/site/* /var/www/html/

chown -R www-data:www-data /var/www/html

systemctl restart apache2
