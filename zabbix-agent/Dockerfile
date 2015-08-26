FROM khipu/base-alpine-s6
MAINTAINER developers@khipu.com

ADD developers@khipu.com-55de074c.rsa.pub /etc/apk/keys/

RUN echo "http://s3.amazonaws.com/alpine.khipu.com/packages/main" >> /etc/apk/repositories \
    && apk add --update zabbix-agent=2.4.6-r1 jq curl \
    && rm -rf /var/cache/apk/*

RUN curl -o /usr/local/bin/confd -SL https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 \
    && chmod +x /usr/local/bin/confd \
    && curl -o etcd-v2.1.2-linux-amd64.tar.gz -SL https://github.com/coreos/etcd/releases/download/v2.1.2/etcd-v2.1.2-linux-amd64.tar.gz \
    && tar xzf etcd-v2.1.2-linux-amd64.tar.gz \
    && mv etcd-v2.1.2-linux-amd64/etcdctl /usr/local/bin \
    && rm -Rf etcd-v2.1.2-linux-amd64/ etcd-v2.1.2-linux-amd64.tar.gz \
    && mkdir /etc/zabbix/zabbix_agentd.conf.d

ADD confd /etc/confd

ADD zabbix.sh /etc/services.d/zabbix-agent/run

ADD entrypoint.sh /

#ENTRYPOINT ["/init"]
ENTRYPOINT ["/entrypoint.sh"]

#CMD ["sh"]
