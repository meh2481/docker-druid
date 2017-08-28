# Base image on Ubuntu
FROM ubuntu:14.04

# Oracle Java 8
RUN   apt-get update  \
      && apt-get install -y software-properties-common \
      && apt-add-repository -y ppa:webupd8team/java \
      && apt-get purge --auto-remove -y software-properties-common \
      && apt-get update \
      && echo oracle-java-8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
      && apt-get install -y oracle-java8-installer \
      && apt-get install -y oracle-java8-set-default \
      && rm -rf /var/cache/oracle-jdk8-installer

# Druid system user
RUN adduser --system --group --no-create-home druid \
      && mkdir -p /var/lib/druid \
      && chown druid:druid /var/lib/druid

# Tranquility (from dist)
RUN mkdir -p /usr/local/druid

# whichever branch you would like to build
ENV TRANQUILITY_VERSION 0.8.0

# Supervisor
RUN apt-get install -y supervisor \
	&& apt-get install -y curl 

# Download and extract
WORKDIR /usr/local/druid
RUN curl -O http://static.druid.io/tranquility/releases/tranquility-distribution-$TRANQUILITY_VERSION.tgz
RUN tar -xzf tranquility-distribution-$TRANQUILITY_VERSION.tgz
RUN cp -R tranquility-distribution-$TRANQUILITY_VERSION/* .
RUN rm -rf tranquility-distribution-$TRANQUILITY_VERSION/
RUN rm tranquility-distribution-$TRANQUILITY_VERSION.tgz

RUN apt-get purge --auto-remove -y curl \
      && apt-get clean

WORKDIR /

CMD bash

##########################################################################################################

# Expose ports:
# - 8081: HTTP (coordinator)
# - 8082: HTTP (broker)
# - 8083: HTTP (historical)
# - 8090: HTTP (overlord)
# - 3306: MySQL
# - 2181 2888 3888: ZooKeeper
# - 8200: Tranquility

EXPOSE 8200

# Setup supervisord
ADD supervisord.conf /etc/supervisor/conf.d/coordinator/supervisord.conf
ADD server.json /var/lib/druid/server.json
ADD starttranquility.sh /var/lib/druid/starttranquility.sh
RUN chmod +x /var/lib/druid/starttranquility.sh

WORKDIR /var/lib/druid

ENTRYPOINT exec /usr/bin/supervisord -c /etc/supervisor/conf.d/coordinator/supervisord.conf
