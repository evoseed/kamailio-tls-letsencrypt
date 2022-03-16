FROM ubuntu:20.04

LABEL maintainer="Giovanni Tommasini <tommasini.giovanni@gmail.com>"

ENV REFRESHED_AT 2022-03-15.01
ENV TZ="Europe/Rome"
ENV DEBIAN_FRONTEND="noninteractive"
ENV KAMAILIO_VERSION="5.5.4"

RUN rm -rf /var/lib/apt/lists/* && apt-get update && apt-get install --assume-yes gnupg wget
RUN echo "deb http://deb.kamailio.org/kamailio55 focal main" > /etc/apt/sources.list.d/kamailio.list
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -
RUN apt-get update && apt-get install --assume-yes kamailio=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-autheph-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-berkeley-bin=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-berkeley-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-cnxcc-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-cpl-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-dbg=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-erlang-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-extra-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-geoip-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-ims-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-json-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-kazoo-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-ldap-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-lua-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-memcached-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-mono-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-mysql-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-nth=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-outbound-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-perl-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-postgres-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-presence-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-python-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-python3-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-rabbitmq-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-radius-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-redis-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-sctp-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-snmpstats-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-sqlite-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-tls-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-unixodbc-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-utils-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-websocket-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-xml-modules=${KAMAILIO_VERSION}+ubuntu20.04 kamailio-xmpp-modules=${KAMAILIO_VERSION}+ubuntu20.04 gettext-base

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
COPY ./ /etc/kamailio/
RUN chmod a+x /etc/kamailio/bootstrap.sh
ENTRYPOINT ["/etc/kamailio/bootstrap.sh"]
