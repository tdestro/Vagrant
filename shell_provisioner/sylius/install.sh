#!/bin/bash

cd /home/vagrant

./cloud_sql_proxy -instances=destromachinesstore:us-central1:destro-machines-store-db=tcp:3306 -credential_file ./DestroMachinesStore-fbf80acedf7b.json &

cd /var/www/sites/sylius

[ "$(ls -A ./sylius)" ] &&echo "Directory sylius is not empty." ||{ php bin/console sylius:install --no-interaction; php bin/console sylius:fixtures:load; }
yarn install
yarn run gulp
