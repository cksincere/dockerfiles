FROM khipu/base-alpine-s6:edge
MAINTAINER developers@khipu.com

RUN apk add --update zabbix-agent=3.2.1-r0 shadow jq bash python python-dev socat curl wget openssl openssl-dev musl-dev libffi-dev gcc py2-pip \
    && pip install pyopenssl \
    && rm -rf /var/cache/apk/* \
    && mkdir /etc/zabbix/zabbix_agentd.conf.d \
    && groupmod -g 2000 zabbix \
    && usermod -u 2000 -g 2000 zabbix

ADD confd /etc/confd

ADD zabbix.sh /etc/services.d/zabbix-agent/run

ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
