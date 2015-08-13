FROM debian:jessie
MAINTAINER developers@khipu.com

RUN echo 'America/Santiago' > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y curl unzip wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -o khipu-base_0.0.2-5_amd64.deb -SL https://s3.amazonaws.com/deb.khipu.com/khipux/khipu-base_0.0.2-5_amd64.deb \
    && dpkg -i khipu-base_0.0.2-5_amd64.deb \
    && rm khipu-base_0.0.2-5_amd64.deb \
    && curl -o /usr/local/bin/confd -SL https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 \
    && chmod +x /usr/local/bin/confd \
    && curl -o etcd-v2.1.1-linux-amd64.tar.gz -SL https://github.com/coreos/etcd/releases/download/v2.1.1/etcd-v2.1.1-linux-amd64.tar.gz \
    && tar xf etcd-v2.1.1-linux-amd64.tar.gz \
    && mv etcd-v2.1.1-linux-amd64/etcdctl /usr/local/bin \
    && rm -Rf etcd-v2.1.1-linux-amd64/ etcd-v2.1.1-linux-amd64.tar.gz

RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 9D6D8F6BC857C906 7638D0442B90D010 7638D0442B90D010

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y gcc make patch \
    && curl -o zabbix-2.4.6.tar.gz -SL http://downloads.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/2.4.6/zabbix-2.4.6.tar.gz \
    && tar xf zabbix-2.4.6.tar.gz \
    && rm zabbix-2.4.6.tar.gz \
    && curl -o zabbix-2.4.0-run_foreground.patch -SL https://support.zabbix.com/secure/attachment/30387/zabbix-2.4.0-run_foreground.patch \
    && cd zabbix-2.4.6 \
    && patch -p0 < ../zabbix-2.4.0-run_foreground.patch \
    && ./configure --disable-server --disable-proxy --disable-java --enable-agent \
    && make install \
    && apt-get purge -y --auto-remove gcc make patch \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && chmod +x /usr/local/bin/gosu

ADD confd /etc/confd

ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
