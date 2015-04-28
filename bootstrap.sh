#!/usr/bin/env bash

apt-get update
apt-get upgrade
apt-get install -y htop
apt-get install -y vim
apt-get install -y curl
apt-get install -y mongodb
#apt-get install -y libxml2
apt-get install -y libxml2-dev
apt-get install -y libexpat1-dev
apt-get install -y libpam-dev

sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password secret'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password secret'
sudo apt-get -y install mysql-server-5.5 

cp /vagrant/bash_profile ~/.bash_profile
echo 'perl-maven' > /etc/hostname

# apt-get install -y apache2
# if ! [ -L /var/www ]; then
#   rm -rf /var/www
#   ln -fs /vagrant /var/www
# fi

apt-get clean

