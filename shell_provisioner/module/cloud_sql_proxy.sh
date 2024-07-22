#!/bin/bash

cd /home/vagrant
pwd
curl -o cloud-sql-proxy https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.9.0/cloud-sql-proxy.linux.amd64
chmod +x cloud-sql-proxy

ln -s /var/www/sites/Sylius /app
