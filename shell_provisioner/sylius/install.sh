#!/bin/bash

cd /home/vagrant

cd /var/www/sites/Sylius

[ "$(ls -A)" ] &&echo "Directory sylius is not empty." ||{ php bin/console sylius:install --no-interaction; php bin/console sylius:fixtures:load; }
yarn install
yarn run gulp

cp /app/dockerincludes/DestroMachinesStore-965e04f545e7.json /app/DestroMachinesStore-965e04f545e7.json

#rm -rf vendor/
COMPOSER_PROCESS_TIMEOUT=2000 composer install --prefer-dist
