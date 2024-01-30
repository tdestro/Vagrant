npm install -g yarn

cd /var/www/sites/Sylius

yarn install
yarn run gulp

cp /var/www/sites/Sylius/dockerincludes/DestroMachinesStore-965e04f545e7.json /var/www/sites/Sylius/DestroMachinesStore-965e04f545e7.json


 
#rm -rf vendor/
COMPOSER_PROCESS_TIMEOUT=2000 composer install --prefer-dist
cd
