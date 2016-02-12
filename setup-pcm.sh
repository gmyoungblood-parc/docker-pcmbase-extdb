#!/bin/bash
#
# docker run -p 8080:8000 -tid --name=PanicPal gmyoungbloodparc/pcmbase  /bin/bash
#
# Fix database
# service postgresql start
# passwd postgres
# ALTER USER Postgres WITH PASSWORD 'postgres1234';
# CREATE DATABASE pcm;
# DATABASE_URL=postgres://postgres:postgres1234@127.0.0.1:5432/pcm
# LOCAL_DATABASE=True

apt-get install -y vim
apt-get install -y wget
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh


# Install Postgres library for Django 
apt-get install -y libpq-dev
pip install psycopg2

# Seaborn
pip install git+git://github.com/mwaskom/seaborn.git#egg=seaborn

# R
#
# Run like this: xvfb-run R --no-save
#
# install.packages("tkrplot", type="source")
# install.packages("nonlinearTseries", type="source")
#
# 'nonlinearTseries'
#
# install.packages("RHRV", repos="http://R-Forge.R-project.org")

# Get the panicpal server code
# 
git clone https://githubenterprise.parc.com/rubin/panicpal_server.git

# Run the server
# gunicorn panicpal_server.wsgi --log-file -
# gunicorn panicpal_server.wsgi -t 300 -b 0.0.0.0:80

ps -ef | grep gunicorn | grep -v grep | awk '{print $2}' | xargs kill -9
nohup gunicorn webinterface.wsgi -t 300 -b 0.0.0.0:80 > /var/log/fittle &

DATABASE_URL=postgres://postgres:postgres1234@127.0.0.1:5432/pcm
CLOUDAMQP_URL=amqp://lzetrzac:AI7vnfspzdsIlhk-Zvrs422Qx123Dw-n@turtle.rmq.cloudamqp.com/lzetrzac
PYTHONBUFFERED=true
PORT=8000
DISPLAY=:0.0

#
#
#
foreman run python manage.py shell_plus --notebook


#ipython_notebook_config.py
c = get_config()

# Kernel config
c.IPKernelApp.pylab = 'inline'  # if you want plotting support always

# Notebook config
c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False
# It is a good idea to put it on a known, fixed port
c.NotebookApp.port = 8888

#
#
#
ssh -L 32768:localhost:32768 -i ~/.docker/machine/machines/default/id_rsa docker@$(docker-machine ip default)

ssh -L 32768:192.168.1.92:32768 -i ~/.docker/machine/machines/default/id_rsa docker@$(docker-machine ip default)



ssh -L 32768:0.0.0.0:32768 -i ~/.docker/machine/machines/default/id_rsa docker@$(docker-machine ip default)

echo "rdr pass proto tcp from any to any port {32768} -> 127.0.0.1 port 32768" | sudo pfctl -Ef -

# pfctl replaced ipfw
#
# container >> localhost
#socat tcp4-listen:32768,fork tcp4:$(docker-machine ip default):32768
socat tcp4-listen:32768,fork tcp4:192.168.99.100:32768
# internet >> localhost
echo "rdr pass proto tcp from any to any port {80} -> 127.0.0.1 port 32768" | sudo pfctl -Ef -

