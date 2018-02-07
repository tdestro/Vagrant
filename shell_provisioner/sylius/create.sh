#!/bin/bash

cd /var/www/sites
 [ "$(ls -A ./sylius)" ] &&echo "Directory sylius is not empty." ||{ git clone https://github.com/tdestro/Sylius-Standard.git ./sylius; cd ./sylius; composer install; }
