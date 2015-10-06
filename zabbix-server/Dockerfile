FROM khipu/base-server-s6
MAINTAINER developers@khipu.com

RUN apk add --update zabbix-pgsql=2.4.6-r1 zabbix-webif=2.4.6-r1 zabbix-utils=2.4.6-r1 nginx php-fpm php-ldap jq \
    && rm -rf /var/cache/apk/*

ADD zabbix-server.sh /etc/services.d/zabbix-server/run
ADD nginx.sh /etc/services.d/nginx/run
ADD php-fpm.sh /etc/services.d/php-fpm/run

ADD confd /etc/confd

ADD conf/nginx.conf /etc/nginx/nginx.conf
ADD conf/php-fpm.conf /etc/php/php-fpm.conf

RUN echo "always_populate_raw_post_data = -1" >> /etc/php/php.ini

ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
