FROM ubuntu:14.04

MAINTAINER Michael Youngblood <Michael.Youngblood@parc.com>

ENV DB_NAME database
ENV DB_USER admin
ENV DB_PASS password

ADD setup-system.sh /tmp/
RUN chmod 755 /tmp/setup-system.sh
RUN /tmp/setup-system.sh

ADD setup-database.sh /docker-entrypoint-initdb.d/
RUN chmod 755 /docker-entrypoint-initdb.d/setup-database.sh

