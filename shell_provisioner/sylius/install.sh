#!/bin/bash

cd /home/vagrant

./cloud_sql_proxy -instances=destromachinesstore:us-central1:destro-machines-store-db=tcp:3306 -credential_file ./DestroMachinesStore-2601b370cb00.json &

cd /var/www/sites/Sylius

[ "$(ls -A)" ] &&echo "Directory sylius is not empty." ||{ php bin/console sylius:install --no-interaction; php bin/console sylius:fixtures:load; }
yarn install
yarn run gulp

cp /app/dockerincludes/DestroMachinesStore-965e04f545e7.json /app/DestroMachinesStore-965e04f545e7.json
