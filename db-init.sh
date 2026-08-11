#!/bin/bash

mysql \
    -h "$MYSQL_HOST" \
    -u "$MYSQL_USER" \
    -p"$MYSQL_PASSWORD" \
    < /var/www/html/sql.sql