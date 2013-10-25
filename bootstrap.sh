#!/usr/bin/env bash

# Ubuntu 12.04 32 bit rails box provision

apt-get -y update

# local time
ln -sf /usr/share/zoneinfo/Australia/Sydney /etc/localtime
# ln -sf /usr/share/zoneinfo/Asia/Singapore /etc/localtime

# for newrelic
# add following to  /etc/apt/sources.list
# deb http://apt.newrelic.com/debian/ newrelic non-free

wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add -

apt-get -y update

# New Relic
apt-get -y install newrelic-sysmond
nrsysmond-config --set license_key=XXXXXXXXXXXXXX
/etc/init.d/newrelic-sysmond start

# git
apt-get -y install git-core

# node
apt-get -y install python-software-properties python g++ make
apt-get -y install software-properties-common
add-apt-repository -y ppa:chris-lea/node.js
apt-get -y update
apt-get -y install nodejs

# sqlite3, mysql, openssl dependency for rails environment
apt-get -y install sqlite3 libsqlite3-dev
apt-get -y install libmysqlclient-dev
apt-get -y install libssl-dev

# Run ruby.sh here as normal user & root to  install Ruby related
# root for deployments. normal user for passenger.

# nginx & passenger
add-apt-repository -y ppa:nginx/stable
gpg --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
gpg --armor --export 561F9B9CAC40B2F7 | apt-key add -
apt-get -y install apt-transport-https
touch /etc/apt/sources.list.d/passenger.list
sh -c "echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger precise main' >> /etc/apt/sources.list.d/passenger.list"
chown root: /etc/apt/sources.list.d/passenger.list
chmod 600 /etc/apt/sources.list.d/passenger.list

apt-get -y update
apt-get -y install nginx-full passenger

# link vagrant folder to hosting folder
rm -rf /var/www
ln -sf /vagrant /var/www

# copy over configuration file
cp -f /vagrant/conf/nginx.conf /etc/nginx/
cp -f /vagrant/conf/virtual.conf /etc/nginx/conf.d/

# install sysv-rc-conf (Ubuntu version of chkconfig)
apt-get -y install sysv-rc-conf

# autostart php-fpm & nginx
sysv-rc-conf nginx on

# start php-fpm & nginx
service nginx start

# run ruby related installation script as vagrant
chmod u+x /vagrant/ruby.sh
# sudo -H -u vagrant /vagrant/ruby.sh
