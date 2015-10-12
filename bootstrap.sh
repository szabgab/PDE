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

# needed for Alien::RRDtool in Task::Munin
apt-get install -y pkg-config 
apt-get install -y libglib2.0-dev
apt-get install -y libcairo-dev
apt-get install -y libpango1.0-dev


# MySQL
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password secret'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password secret'
sudo apt-get -y install mysql-server
sudo apt-get -y install libmysqld-dev

# PostgreSQL
sudo apt-get -y install postgresql
sudo apt-get -y install postgresql-server-dev-9.4


echo "copying bash_profile"
cp /vagrant/bash_profile /home/vagrant/.bash_profile
chown vagrant.vagrant /home/vagrant/.bash_profile
cp /vagrant/gitconfig /home/vagrant/.gitconfig
chown vagrant.vagrant /home/vagrant/.gitconfig
echo 'perl-maven' > /etc/hostname

# apt-get install -y apache2
# if ! [ -L /var/www ]; then
#   rm -rf /var/www
#   ln -fs /vagrant /var/www
# fi

apt-get clean

