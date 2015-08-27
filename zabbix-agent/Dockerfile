FROM khipu/base-server-s6
MAINTAINER developers@khipu.com

RUN apk add --update zabbix-agent=2.4.6-r1 jq \
    && rm -rf /var/cache/apk/* \
    && mkdir /etc/zabbix/zabbix_agentd.conf.d

ADD confd /etc/confd

ADD zabbix.sh /etc/services.d/zabbix-agent/run

ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
