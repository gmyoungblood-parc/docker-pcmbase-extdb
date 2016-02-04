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
apt-get install -y postgresql-9.3 postgresql-contrib-9.3 

# R system
#
apt-get install -y r-base

# Packages in aptfile
#
apt-get install -y mesa-common-dev
apt-get install -y libglu1-mesa-dev
apt-get install -y tk-dev
apt-get install -y tcl-dev
apt-get install -y tk8.4-dev
apt-get install -y tk8.5-dev
apt-get install -y tk8.6-dev

# Python packages
#
pip install amqp==1.4.6
pip install anyjson==0.3.3
pip install backports.ssl-match-hostname==3.4.0.2
pip install billiard==3.3.0.19
pip install Bottleneck==1.0.0
pip install celery==3.1.17
pip install certifi==14.5.14
pip install distribute==0.6.31
pip install dj-database-url==0.3.0
pip install dj-static==0.0.6
pip install Django==1.7.5
pip install django-autofixture==0.9.2
pip install django-celery==3.1.16
pip install django-custom-user==0.5
pip install django-extensions==1.5.2
pip install django-filter==0.9.2
pip install django-picklefield==0.3.1
pip install django-toolbelt==0.0.1
pip install djangorestframework==3.1.0
pip install gnureadline==6.3.3
pip install gunicorn==19.0.0
pip install ipython==3.0.0
pip install Jinja2==2.7.3
pip install jsonschema==2.4.0
pip install kombu==3.0.24
pip install Markdown==2.6
pip install MarkupSafe==0.23
pip install matplotlib==1.4.3
pip install mistune==0.5.1
pip install mock==1.0.1
pip install nose==1.3.4
pip install numexpr==2.4rc2
pip install numpy==1.8.1
pip install pandas==0.16.0
pip install psycopg2==2.6
pip install ptyprocess==0.4
pip install Pygments==2.0.2
pip install pyparsing==2.0.3
pip install python-dateutil==2.4.1
pip install pytz==2014.10
pip install pyzmq==14.5.0
pip install scikit-learn==0.16b1
pip install scipy==0.14.0
pip install selenium==2.45.0
pip install singledispatch==3.4.0.3
pip install six==1.9.0
pip install static3==0.5.1
pip install terminado==0.5
pip install tornado==4.1
pip install wsgiref==0.1.2

