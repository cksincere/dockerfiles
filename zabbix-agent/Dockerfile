FROM khipu/base-server-s6
MAINTAINER developers@khipu.com

RUN addgroup -g 2000 -S zabbix \
    && adduser -u 2000 -G zabbix -S zabbix \
    && apk add --update zabbix-agent=2.4.6-r1 jq bash \
    && rm -rf /var/cache/apk/* \
    && mkdir /etc/zabbix/zabbix_agentd.conf.d

ADD confd /etc/confd

ADD zabbix.sh /etc/services.d/zabbix-agent/run

ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
