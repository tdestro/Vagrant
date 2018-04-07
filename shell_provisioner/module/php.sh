#!/bin/bash

# PHP

apt install -y apt-transport-https lsb-release ca-certificates
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ jessie main" > /etc/apt/sources.list.d/php.list
sudo apt update

apt-get -y install php7.2-cli php7.2-fpm php7.2-dev php7.2-curl php7.2-intl \
    php7.2-mysql php7.2-sqlite3 php7.2-gd php7.2-mbstring php7.2-xml php-pear

pecl install protobuf
pecl install xdebug
# php7.2-fpm.sock needs changed in shell_provisioner/config/apache/sylius.vhost if
# fpm version is changed.
sed -i 's/;date.timezone.*/date.timezone = UTC/' /etc/php/7.2/fpm/php.ini
sed -i 's/;date.timezone.*/date.timezone = UTC/' /etc/php/7.2/cli/php.ini
sed -i 's/^user = www-data/user = vagrant/' /etc/php/7.2/fpm/pool.d/www.conf
sed -i 's/^group = www-data/group = vagrant/' /etc/php/7.2/fpm/pool.d/www.conf
sed -i -r -e 's/display_errors = Off/display_errors = On/g' /etc/php/7.2/fpm/php.ini
sed -i -r -e 's/display_errors = Off/display_errors = On/g' /etc/php/7.2/cli/php.ini
sed -i 's/memory_limit = .*/memory_limit = -1/' /etc/php/7.2/cli/php.ini
sed -i 's/memory_limit = .*/memory_limit = -1/' /etc/php/7.2/fpm/php.ini
echo "extension=protobuf.so" >> /etc/php/7.2/cli/php.ini
echo "extension=protobuf.so" >> /etc/php/7.2/fpm/php.ini

echo "[Xdebug]" >> /etc/php/7.2/cli/php.ini
echo "zend_extension=/usr/lib/php/20170718/xdebug.so" >> /etc/php/7.2/cli/php.ini
echo "xdebug.remote_enable=1" >> /etc/php/7.2/cli/php.ini
echo "xdebug.remote_host=10.0.2.2" >> /etc/php/7.2/cli/php.ini
echo "xdebug.profiler_enable=1" >> /etc/php/7.2/cli/php.ini
echo "xdebug.profiler_output_dir=\"<AMP home\tmp>\"" >> /etc/php/7.2/cli/php.ini

echo "[Xdebug]" >> /etc/php/7.2/fpm/php.ini
echo "zend_extension=/usr/lib/php/20170718/xdebug.so" >> /etc/php/7.2/fpm/php.ini
echo "xdebug.remote_enable=1" >> /etc/php/7.2/fpm/php.ini
echo "xdebug.remote_host=10.0.2.2" >> /etc/php/7.2/fpm/php.ini
echo "xdebug.profiler_enable=1" >> /etc/php/7.2/fpm/php.ini
echo "xdebug.profiler_output_dir=\"<AMP home\tmp>\"" >> /etc/php/7.2/fpm/php.ini

service php7.2-fpm restart

# composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin
ln -s /usr/bin/composer.phar /usr/bin/composer
