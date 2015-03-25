#!/usr/bin/env bash

apt-get update
apt-get install -y htop
apt-get install -y vim
apt-get install -y curl
apt-get install -y mongodb

sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password secret'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password secret'
sudo apt-get -y install mysql-server-5.5 

cp /vagrant/bash_profile ~/.bash_profile

# apt-get install -y apache2
# if ! [ -L /var/www ]; then
#   rm -rf /var/www
#   ln -fs /vagrant /var/www
# fi

apt-get clean

