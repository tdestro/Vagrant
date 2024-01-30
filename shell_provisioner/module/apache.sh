#!/bin/bash

# Apache
apt-get install -y apache2 libapache2-mod-fcgid
a2enmod rewrite expires headers proxy proxy_http proxy_fcgi actions fastcgi alias ssl

# Activate vhost
a2dissite 000-default

chmod -R a+rX /var/log/apache2
sed -i 's/640/666/' /etc/logrotate.d/apache2

echo 'Listen 80
      Listen 443
' >  /etc/apache2/ports.conf

cat ${CONFIG_PATH}/apache/sylius.vhost.conf > /etc/apache2/sites-available/${APP_DOMAIN}.conf
a2ensite ${APP_DOMAIN}.conf
echo "ServerName sylius.local" >>  /etc/apache2/sites-enabled/000-default.conf
echo "SSLEngine on" >>  /etc/apache2/sites-enabled/000-default.conf
echo "SSLCertificateFile /home/vagrant/sylius.local.crt" >>  /etc/apache2/sites-enabled/000-default.conf
echo "SSLCertificateKeyFile /home/vagrant/sylius.local.key" >>  /etc/apache2/sites-enabled/000-default.conf
service apache2 restart
