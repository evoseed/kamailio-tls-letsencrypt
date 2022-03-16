FROM postgres:13.1

LABEL maintainer="Giovanni Tommasini <tommasini.giovanni@gmail.com>"

ENV REFRESHED_AT 2022-03-15.01
ENV TZ="Europe/Rome"

COPY init_db.sql /docker-entrypoint-initdb.d/
