FROM ubuntu:14.04

MAINTAINER Michael Youngblood <Michael.Youngblood@parc.com>

ENV DATABASE_URL postgres://postgres:postgres1234@127.0.0.1:5432/pcm
ENV PORT 8000
ENV LOCAL_POSTGRES true

EXPOSE 5432
EXPOSE 8000
EXPOSE 8888-8890

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y gcc
RUN apt-get install -y git
RUN apt-get install -y python-pip
RUN apt-get install -y libxml2-dev libxslt-dev
RUN apt-get install -y python-dev
RUN apt-get install -y lib32z1-dev
#RUN apt-get install -y libssl
RUN apt-get install -y libssl-dev
RUN apt-get install -y gunicorn
RUN apt-get install -y sendmail
RUN apt-get install -y vim
RUN apt-get install -y wget
RUN apt-get install -y python-numpy 
RUN apt-get install -y python-scipy
RUN apt-get install -y liblzma-dev

# PostgreSQL 9.3 Database
#
RUN apt-get install -y postgresql-9.3 postgresql-contrib-9.3 
RUN apt-get install -y libpq-dev

# Packages in aptfile for tcl/tk
#
RUN apt-get install -y mesa-common-dev
RUN apt-get install -y libglu1-mesa-dev
RUN apt-get install -y tk-dev
RUN apt-get install -y tcl-dev
RUN apt-get install -y tk8.4-dev
RUN apt-get install -y tk8.5-dev
RUN apt-get install -y tk8.6-dev

# Heroku Toolbelt
#
RUN wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
RUN gem install foreman

# Virtual framebuffer for R
#
RUN apt-get install -y xvfb 
RUN apt-get install -y xauth 
RUN apt-get install -y xfonts-base

# R system
# From https://www.digitalocean.com/community/tutorials/how-to-set-up-r-on-ubuntu-14-04
#
RUN sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list'
RUN gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
RUN gpg -a --export E084DAB9 | sudo apt-key add -
RUN apt-get update
RUN apt-get install -y r-base
RUN apt-get install -y r-base-dev
RUN apt-get install -y r-cran-tkrplot
RUN apt-get install -y libopenblas-base 
RUN apt-get install -y r-cran-tseries
#RUN apt-get install -y libpng-dev
#RUN apt-get install -y zlib1g-dev
RUN xvfb-run R --no-save -e "install.packages('lomb', repos = 'http://cran.R-project.org')"
RUN xvfb-run R --no-save -e "install.packages('TSA', repos = 'http://cran.R-project.org')"
#RUN xvfb-run R --no-save -e "install.packages('nonlinearTseries', repos = 'http://R-Forge.R-project.org')"
#RUN xvfb-run R --no-save -e "install.packages('RHRV', repos = 'http://R-Forge.R-project.org')"

# Python Dependencies

RUN pip install numpy==1.10.4
RUN pip install ipython==3.0.0
RUN pip install pandas==0.16.0
#
RUN pip install amqp==1.4.6
RUN pip install anyjson==0.3.3
RUN pip install backports.ssl-match-hostname==3.4.0.2
RUN pip install billiard==3.3.0.19
RUN pip install Bottleneck==1.0.0
RUN pip install celery==3.1.17
RUN pip install certifi==14.5.14
#RUN pip install distribute==0.6.31
RUN pip install dj-database-url==0.3.0
RUN pip install dj-static==0.0.6
RUN pip install Django==1.7.5
RUN pip install django-autofixture==0.9.2
RUN pip install django-celery==3.1.16
RUN pip install django-custom-user==0.5
RUN pip install django-extensions==1.5.2
RUN pip install django-filter==0.9.2
RUN pip install django-picklefield==0.3.1
RUN pip install django-toolbelt==0.0.1
RUN pip install djangorestframework==3.1.0
RUN pip install gnureadline==6.3.3
RUN pip install gunicorn==19.0.0
RUN pip install Jinja2==2.7.3
RUN pip install jsonschema==2.4.0
RUN pip install kombu==3.0.24
RUN pip install Markdown==2.6
RUN pip install MarkupSafe==0.23
RUN pip install matplotlib==1.4.3
RUN pip install mistune==0.5.1
RUN pip install mock==1.0.1
RUN pip install nose==1.3.4
RUN pip install numexpr==2.4rc2
RUN pip install psycopg2==2.6
RUN pip install ptyprocess==0.4
RUN pip install Pygments==2.0.2
RUN pip install pyparsing==2.0.3
RUN pip install python-dateutil==2.4.1
RUN pip install pytz==2014.10
RUN pip install pyzmq==14.5.0
RUN pip install rpy2==2.7.4
RUN pip install scikit-learn==0.16b1
RUN pip install scipy==0.14.0
RUN pip install selenium==2.45.0
RUN pip install singledispatch==3.4.0.3
RUN pip install six==1.9.0
RUN pip install static3==0.5.1
RUN pip install terminado==0.5
RUN pip install tornado==4.1
RUN pip install wsgiref==0.1.2
RUN pip install psycopg2
#
RUN pip install git+git://github.com/mwaskom/seaborn.git#egg=seaborn

# Setup database
#
RUN service postgresql start
ADD setup-database.sh /docker-entrypoint-initdb.d/
RUN chmod 755 /docker-entrypoint-initdb.d/setup-database.sh

#ENTRYPOINT ["/usr/local/"]