#!/bin/bash

wget -q https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy
chmod +x cloud_sql_proxy

ln -s /var/www/sites/Sylius /app
