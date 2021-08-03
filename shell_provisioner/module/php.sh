#!/bin/bash

# PHP

apt install -y apt-transport-https lsb-release ca-certificates
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ buster main" > /etc/apt/sources.list.d/php.list
sudo apt update

apt-get -y install php7.4 php7.4-cli php7.4-apcu php7.4-mbstring php7.4-curl php7.4-gd php7.4-imagick php7.4-intl php7.4-bcmath \
        php7.4-pgsql php7.4-soap php7.4-xdebug php7.4-xml php7.4-zip php7.4-ldap \
        php7.4-fpm php7.4-dev php-pear libzip-dev zip jpegoptim

pecl channel-update pecl.php.net && \
pear channel-update pear.php.net && \
pecl install protobuf && \
echo "extension=protobuf.so" >> /etc/php/7.4/fpm/php.ini && \
echo "extension=protobuf.so" >> /etc/php/7.4/cli/php.ini

# php7.4-fpm.sock needs changed in
# shell_provisioner/config/apache/sylius.vhost if
# fpm version is changed.
sed -i 's/;error_log = php_errors.log/error_log = \/var\/www\/sites\/Sylius\/php_errors.log/g' /etc/php/7.4/fpm/php.ini
sed -i 's/;error_log = php_errors.log/error_log = \/var\/www\/sites\/Sylius\/php_errors.log/g' /etc/php/7.4/cli/php.ini
sed -i 's/;date.timezone.*/date.timezone = UTC/g' /etc/php/7.4/fpm/php.ini
sed -i 's/;date.timezone.*/date.timezone = UTC/g' /etc/php/7.4/cli/php.ini
sed -i 's/^user = www-data/user = vagrant/' /etc/php/7.4/fpm/pool.d/www.conf
sed -i 's/^group = www-data/group = vagrant/' /etc/php/7.4/fpm/pool.d/www.conf
sed -i -r -e 's/display_errors = Off/display_errors = On/g' /etc/php/7.4/fpm/php.ini
sed -i -r -e 's/display_errors = Off/display_errors = On/g' /etc/php/7.4/cli/php.ini
sed -i 's/memory_limit = .*/memory_limit = -1/' /etc/php/7.4/cli/php.ini
sed -i 's/memory_limit = .*/memory_limit = -1/' /etc/php/7.4/fpm/php.ini
sed -i 's/post_max_size = .*/post_max_size = 5M/' /etc/php/7.4/fpm/php.ini
sed -i 's/upload_max_filesize = .*/upload_max_filesize = 5M/' /etc/php/7.4/fpm/php.ini
#sed -i 's/max_execution_time .*/max_execution_time = 900/' /etc/php/7.4/fpm/php.ini

echo "[Xdebug]" >> /etc/php/7.4/cli/php.ini
echo "xdebug.remote_enable=1" >> /etc/php/7.4/cli/php.ini
echo "xdebug.remote_host=192.168.0.118" >> /etc/php/7.4/cli/php.ini
echo "xdebug.remote_port=9005" >> /etc/php/7.4/cli/php.ini
echo "xdebug.profiler_enable=1" >> /etc/php/7.4/cli/php.ini
echo "xdebug.profiler_output_dir=\"<AMP home\tmp>\"" >> /etc/php/7.4/cli/php.ini
echo "xdebug.max_nesting_level=10000" >> /etc/php/7.4/cli/php.ini
echo "xdebug.remote_log=\"/var/www/sites/Sylius/xdebug.log\"" >> /etc/php/7.4/cli/php.ini

echo "[Xdebug]" >> /etc/php/7.4/fpm/php.ini
echo "xdebug.remote_enable=1" >> /etc/php/7.4/fpm/php.ini
echo "xdebug.remote_host=192.168.0.118" >> /etc/php/7.4/fpm/php.ini
echo "xdebug.remote_port=9005" >> /etc/php/7.4/fpm/php.ini
echo "xdebug.profiler_enable=1" >> /etc/php/7.4/fpm/php.ini
echo "xdebug.profiler_output_dir=\"<AMP home\tmp>\"" >> /etc/php/7.4/fpm/php.ini
echo "xdebug.max_nesting_level=10000" >> /etc/php/7.4/fpm/php.ini
echo "xdebug.remote_log=\"/var/www/sites/Sylius/xdebug.log\"" >> /etc/php/7.4/fpm/php.ini

service php7.4-fpm restart

# composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin
ln -s /usr/bin/composer.phar /usr/bin/composer
