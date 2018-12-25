#!/bin/bash

cd /var/www/sites
 [ "$(ls -A ./Sylius)" ] &&echo "Directory Sylius is not empty." ||{ git clone https://github.com/tdestro/Sylius.git ./Sylius; cd ./Sylius; composer install; }
