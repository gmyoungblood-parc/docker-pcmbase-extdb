# Dockerfile for pcmbase-mysql
#
# Designed for Research development using
#              Gunicorn-Python-Django Server with SciPy and R support
#              iNotebook Server
#              Remote MySQL Database (5.5) connection
#
# 2016 PARC, a Xerox company
#
FROM ubuntu:14.04
MAINTAINER Michael Youngblood <Michael.Youngblood@parc.com>
#
# TO DO:
# 1. Eliminate unnecessary items
# 2. Reduce layers
# 3. Reduce size of container
# 4. Split this into 3 containers (server, notebook, database)
# 
#########################################################################################

ENV DATABASE_URL mysql://USER:PASSWORD@HOST:PORT/NAME
ENV PORT 8000

EXPOSE 8000
EXPOSE 8888-8890

# Base Packages
RUN apt-get -y update && apt-get install --no-install-recommends -y gcc \
	git \
	gunicorn \
	lib32z1-dev \
	libfreetype6-dev \
	liblzma-dev \
	libssl-dev \
	libxml2-dev \
	libxslt-dev \
	pkg-config \
	python-dev \
	python-numpy \ 
	python-pip \
	python-scipy \
	vim \
	wget ; apt-get autoremove ; sudo rm -rf /tmp/*
#	sendmail \

# MySQL 5.5 Database
#
RUN apt-get install --no-install-recommends -y python-mysqldb \
	; apt-get autoremove ; sudo rm -rf /tmp/*

# Packages in aptfile for tcl/tk
#
#RUN apt-get install --no-install-recommends -y mesa-common-dev \
#	libglu1-mesa-dev \
#	tk-dev \
#	tcl-dev \
#	tk8.4-dev \
#	tk8.5-dev \
#	tk8.6-dev ; apt-get autoremove ; sudo rm -rf /tmp/*

# Virtual framebuffer for R
#
RUN apt-get install --no-install-recommends -y xvfb \
	xauth \
	xfonts-base ; apt-get autoremove ; sudo rm -rf /tmp/*

# R system
# From https://www.digitalocean.com/community/tutorials/how-to-set-up-r-on-ubuntu-14-04
#
RUN sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list' ; \
	gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 ; \
	gpg -a --export E084DAB9 | sudo apt-key add -

RUN apt-get update && apt-get install --no-install-recommends -y r-base \
	r-base-dev \
	r-cran-tkrplot \
	libopenblas-base \
	r-cran-tseries ; apt-get autoremove ; sudo rm -rf /tmp/*
	
RUN sudo su - -c "xvfb-run R --no-save -e \"install.packages('lomb', repos = 'http://cran.R-project.org')\"" 
RUN sudo su - -c "xvfb-run R --no-save -e \"install.packages('TSA', repos = 'http://cran.R-project.org')\"" 
RUN sudo su - -c "xvfb-run R --no-save -e \"install.packages('Rcpp', repos = 'http://cran.R-project.org')\"" 
RUN sudo su - -c "xvfb-run R --no-save -e \"install.packages('nonlinearTseries', repos = 'http://R-Forge.R-project.org')\"" 
RUN sudo su - -c "xvfb-run R --no-save -e \"install.packages('RHRV', repos = 'http://R-Forge.R-project.org')\""

# Python Django Dependencies
#
RUN pip install anyjson==0.3.3 \
    numpy==1.10.4 \
    Bottleneck==1.0.0 \
	ipython==3.0.0 \
	pandas==0.16.0 \
	backports.ssl-match-hostname==3.4.0.2 \
	certifi==14.5.14 \
	dj-database-url==0.3.0 \
	dj-static==0.0.6 \
	Django==1.7.5 \
	django-autofixture==0.9.2 \
	django-custom-user==0.5 \
	django-extensions==1.5.2 \
	django-filter==0.9.2 \
	django-picklefield==0.3.1 \
	djangorestframework==3.1.0 \
	django-toolbelt==0.0.1 \
	gunicorn==19.0.0 \
	jsonschema==2.4.0 \
	Markdown==2.6 \
	mistune==0.5.1 \
	MarkupSafe==0.23 \
	matplotlib==1.5.1 \
	nose==1.3.4 \
	numexpr==2.4rc2 \
	pyparsing==2.0.3 \
	python-dateutil==2.4.1 \
	pytz==2014.10 \
	rpy2==2.7.4 \
	scikit-learn==0.16b1 \
	scipy==0.14.0 \
	selenium==2.45.0 \
	singledispatch==3.4.0.3 \
	six==1.9.0 \
	static3==0.5.1 \
	tornado==4.1 \
	terminado==0.5 \
	wsgiref==0.1.2 \
	ptyprocess==0.4 \
	Pygments==2.0.2 
	
# Culled libraries, the ones above appear to be used, these do not
#	 
#	amqp==1.4.6 \	
#	billiard==3.3.0.19 \
#	celery==3.1.17 \
#	django-celery==3.1.16 \
# 	kombu==3.0.24 \
#
#	gnureadline==6.3.3 \	
#	Jinja2==2.7.3 \
#	mock==1.0.1 \
#	pyzmq==14.5.0 \
#
# psycopg2==2.6.1

# External Python Packages
RUN pip install git+git://github.com/mwaskom/seaborn.git#egg=seaborn

# Heroku Toolbelt
RUN wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh ; gem install foreman

# Cleanup
RUN apt-get autoremove ; sudo rm -rf /tmp/*

# fin.
