#!/bin/bash

# PHP

apt install -y apt-transport-https lsb-release ca-certificates
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ bookworm main" > /etc/apt/sources.list.d/php.list
sudo apt update

apt-get -y install php8.1 php8.1-cli php8.1-apcu php8.1-mbstring php8.1-curl php8.1-gd php8.1-imagick php8.1-intl php8.1-bcmath \
        php8.1-pgsql php8.1-soap php8.1-xdebug php8.1-xml php8.1-zip php8.1-ldap \
        php8.1-fpm php8.1-dev php-pear libzip-dev zip jpegoptim

pecl channel-update pecl.php.net && \
pear channel-update pear.php.net && \
pecl install protobuf && \
echo "extension=protobuf.so" >> /etc/php/8.1/fpm/php.ini && \
echo "extension=protobuf.so" >> /etc/php/8.1/cli/php.ini

# php8.1-fpm.sock needs changed in
# shell_provisioner/config/apache/sylius.vhost if
# fpm version is changed.
sed -i 's/;error_log = php_errors.log/error_log = \/var\/www\/sites\/Sylius\/php_errors.log/g' /etc/php/8.1/fpm/php.ini
sed -i 's/;error_log = php_errors.log/error_log = \/var\/www\/sites\/Sylius\/php_errors.log/g' /etc/php/8.1/cli/php.ini
sed -i 's/;date.timezone.*/date.timezone = UTC/g' /etc/php/8.1/fpm/php.ini
sed -i 's/;date.timezone.*/date.timezone = UTC/g' /etc/php/8.1/cli/php.ini
sed -i 's/^user = www-data/user = vagrant/' /etc/php/8.1/fpm/pool.d/www.conf
sed -i 's/^group = www-data/group = vagrant/' /etc/php/8.1/fpm/pool.d/www.conf
sed -i -r -e 's/display_errors = Off/display_errors = On/g' /etc/php/8.1/fpm/php.ini
sed -i -r -e 's/display_errors = Off/display_errors = On/g' /etc/php/8.1/cli/php.ini
sed -i 's/memory_limit = .*/memory_limit = -1/' /etc/php/8.1/cli/php.ini
sed -i 's/memory_limit = .*/memory_limit = -1/' /etc/php/8.1/fpm/php.ini
sed -i 's/post_max_size = .*/post_max_size = 5M/' /etc/php/8.1/fpm/php.ini
sed -i 's/upload_max_filesize = .*/upload_max_filesize = 5M/' /etc/php/8.1/fpm/php.ini
#sed -i 's/max_execution_time .*/max_execution_time = 900/' /etc/php/8.1/fpm/php.ini

echo "xdebug.mode=debug" >> /etc/php/8.1/cli/conf.d/20-xdebug.ini
echo "xdebug.client_host=10.0.2.2" >> /etc/php/8.1/cli/conf.d/20-xdebug.ini
echo "xdebug.client_port=9003" >> /etc/php/8.1/cli/conf.d/20-xdebug.ini
#echo "xdebug.file_link_format=\"phpstorm://open?file=%%f&line=%%l&/var/www/>~/PhpstormProjects/Vagrant/\"" >> /etc/php/8.1/cli/conf.d/20-xdebug.ini
echo "xdebug.mode=debug" >> /etc/php/8.1/fpm/conf.d/20-xdebug.ini
echo "xdebug.client_host=10.0.2.2" >> /etc/php/8.1/fpm/conf.d/20-xdebug.ini
echo "xdebug.client_port=9003" >>  /etc/php/8.1/fpm/conf.d/20-xdebug.ini
#echo "xdebug.file_link_format=\"phpstorm://open?file=%%f&line=%%l&/var/www/>~/PhpstormProjects/Vagrant/\"" >> /etc/php/8.1/fpm/conf.d/20-xdebug.ini

service php8.1-fpm restart

# composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin
ln -s /usr/bin/composer.phar /usr/bin/composer
