#!/usr/bin/env bash

# Ubuntu 12.04 32 bit rails box provision

sudo apt-get -y update

# local time
sudo ln -sf /usr/share/zoneinfo/Australia/Sydney /etc/localtime
# ln -sf /usr/share/zoneinfo/Asia/Singapore /etc/localtime

# git
sudo apt-get -y install git-core

# node
sudo apt-get -y install python-software-properties python g++ make
sudo apt-get -y install software-properties-common
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get -y update
sudo apt-get -y install nodejs

# rbenv & ruby-build
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.profile
echo 'eval "$(rbenv init -)"' >> ~/.profile
exec $SHELL -l
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# ruby
rbenv install 2.0.0-p247
rbenv global 2.0.0-p247
rbenv rehash

# sqlite3 for rails environment
sudo apt-get -y install sqlite3 libsqlite3-dev

# rails
gem install rails
rbenv rehash

# nginx & passenger
sudo add-apt-repository -y ppa:nginx/stable

gpg --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
gpg --armor --export 561F9B9CAC40B2F7 | sudo apt-key add -
sudo apt-get -y install apt-transport-https
sudo touch /etc/apt/sources.list.d/passenger.list
sudo sh -c "echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger precise main' >> /etc/apt/sources.list.d/passenger.list"
sudo chown root: /etc/apt/sources.list.d/passenger.list
sudo chmod 600 /etc/apt/sources.list.d/passenger.list

sudo apt-get -y update
sudo apt-get -y install nginx-full passenger

# link vagrant folder to hosting folder
rm -rf /var/www
sudo ln -sf /vagrant /var/www

# copy over configuration file
sudo cp -f /vagrant/conf/nginx.conf /etc/nginx/
sudo cp -f /vagrant/conf/virtual.conf /etc/nginx/conf.d/

# install sysv-rc-conf (Ubuntu version of chkconfig)
sudo apt-get -y install sysv-rc-conf

# autostart php-fpm & nginx
sudo sysv-rc-conf nginx on

# start php-fpm & nginx
sudo service nginx start

