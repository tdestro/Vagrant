#!/bin/bash

cd /var/www/sites/sylius

sed -i "s/env(SYLIUS_DATABASE_PASSWORD): null/env(SYLIUS_DATABASE_PASSWORD): vagrant/g" app/config/parameters.yml

[ "$(ls -A ./sylius)" ] &&echo "Directory sylius is not empty." ||{ php bin/console sylius:install --no-interaction; php bin/console sylius:fixtures:load; }
yarn install
yarn run gulp
