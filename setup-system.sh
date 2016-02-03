#!/bin/sh
apt-get -y  update
apt-get -y upgrade
apt-get install -y gcc
apt-get install -y git
apt-get install -y python-pip
apt-get install -y libxml2-dev libxslt-dev
apt-get install -y python-dev
apt-get install -y lib32z1-dev
apt-get install -y libssl
apt-get install -y libssl-dev
apt-get install -y gunicorn
apt-get install -y sendmail
#apt-get install -y postgresql-9.3 postgresql-contrib-9.3 

