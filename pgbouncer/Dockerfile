FROM khipu/base-alpine-s6
MAINTAINER developers@khipu.com

RUN apk -U add pgbouncer \
    && rm -rf /var/cache/apk/* \
    && mkdir /etc/pgbouncer

COPY confd /etc/confd

COPY s6/pgbouncer.sh /etc/services.d/pgbouncer/run
COPY s6/confd.sh /etc/services.d/confd/run
COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
