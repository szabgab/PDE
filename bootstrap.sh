#!/usr/bin/env bash

sudo apt-get update
sudo apt-get upgrade
sudo apt-get autoremove -y
sudo apt-get install -y htop
sudo apt-get install -y tree
sudo apt-get install -y vim
sudo apt-get install -y curl
sudo apt-get install -y git
sudo apt-get install -y mongodb
#sudo apt-get install -y libxml2
sudo apt-get install -y libxml2-dev
sudo apt-get install -y libexpat1-dev
sudo apt-get install -y libpam-dev
sudo apt-get install -y libdb-dev
sudo apt-get install -y redis-server
sudo apt-get install -y sqlite3
sudo apt-get install -y libsqlite3-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y elasticsearch

# needed for Alien::RRDtool in Task::Munin
sudo apt-get install -y pkg-config 
sudo apt-get install -y libglib2.0-dev
sudo apt-get install -y libcairo-dev
sudo apt-get install -y libpango1.0-dev


# MySQL
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password secret'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password secret'
sudo apt-get -y install mysql-server
sudo apt-get -y install libmysqld-dev

# PostgreSQL
sudo apt-get -y install postgresql
sudo apt-get -y install postgresql-server-dev-9.4


echo "copying bash_profile"
cp /vagrant/bash_profile ~/.bash_profile
cp /vagrant/gitconfig ~/.gitconfig
echo "Result: $?"
echo 'perl-maven' | sudo tee /etc/hostname

# apt-get install -y apache2
# if ! [ -L /var/www ]; then
#   rm -rf /var/www
#   ln -fs /vagrant /var/www
# fi

sudo apt-get clean

