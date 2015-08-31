FROM alpine:3.2
MAINTAINER developers@khipu.com

ADD developers@khipu.com-55de074c.rsa.pub /etc/apk/keys/

RUN echo "http://s3.amazonaws.com/alpine.khipu.com/packages/main" >> /etc/apk/repositories \
    && apk add --update curl tzdata \
    && rm -rf /var/cache/apk/*

RUN cp /usr/share/zoneinfo/America/Santiago /etc/localtime \
    && echo "America/Santiago" > /etc/timezone \
    && addgroup -g 2000 -S khipu \
    && adduser -u 2000 -G khipu -S khipu \
    && mkdir -p /opt/khipu \
    && cd /opt/khipu \
    && mkdir bin etc share log var \
    && chown -R khipu:khipu /opt/khipu

RUN curl -o /usr/local/bin/confd -sSL https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 \
    && chmod +x /usr/local/bin/confd \
    && curl -o etcd-v2.1.2-linux-amd64.tar.gz -sSL https://github.com/coreos/etcd/releases/download/v2.1.2/etcd-v2.1.2-linux-amd64.tar.gz \
    && tar xzf etcd-v2.1.2-linux-amd64.tar.gz \
    && mv etcd-v2.1.2-linux-amd64/etcdctl /usr/local/bin \
    && rm -Rf etcd-v2.1.2-linux-amd64/ etcd-v2.1.2-linux-amd64.tar.gz
