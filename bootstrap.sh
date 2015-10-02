#!/usr/bin/env bash

apt-get update
apt-get upgrade
apt-get autoremove -y
apt-get install -y htop
apt-get install -y tree
apt-get install -y vim
apt-get install -y curl
apt-get install -y git
apt-get install -y mongodb
#apt-get install -y libxml2
apt-get install -y libxml2-dev
apt-get install -y libexpat1-dev
apt-get install -y libpam-dev
apt-get install -y libdb-dev
apt-get install -y redis-server
apt-get install -y sqlite3
apt-get install -y libsqlite3-dev
apt-get install -y libssl-dev
apt-get install -y elasticsearch

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password secret'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password secret'
sudo apt-get -y install mysql-server

echo "copying bash_profile"
cp /vagrant/bash_profile ~/.bash_profile
cp /vagrant/gitconfig ~/.gitconfig
echo "Result: $?"
echo 'perl-maven' > /etc/hostname

# apt-get install -y apache2
# if ! [ -L /var/www ]; then
#   rm -rf /var/www
#   ln -fs /vagrant /var/www
# fi

apt-get clean

