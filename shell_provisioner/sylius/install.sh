#!/bin/bash

cd /home/vagrant

./cloud_sql_proxy -instances=destromachinesstore:us-central1:destro-machines-store-db=tcp:3306 -credential_file ./DestroMachinesStore-2601b370cb00.json &

cd /var/www/sites/sylius

sudo sed -i 's/memory_limit = .*/memory_limit = -1/' /etc/php/7.1/cli/php.ini

[ "$(ls -A)" ] &&echo "Directory sylius is not empty." ||{ php bin/console sylius:install --no-interaction; php bin/console sylius:fixtures:load; }
yarn install
yarn run gulp
