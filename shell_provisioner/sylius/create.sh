#!/bin/bash

cd /var/www/sites
 [ "$(ls -A ./sylius)" ] && echo "Directory sylius is not empty." || { composer create-project --no-progress -n sylius/sylius-standard ./sylius; rm ./sylius/.gitignore; }
