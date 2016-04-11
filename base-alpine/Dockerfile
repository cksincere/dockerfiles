FROM alpine:edge
MAINTAINER developers@khipu.com

ARG CONFD_VERSION=0.11.0
ARG ETCD_VERSION=2.2.5
ARG GOSU_VERSION=1.7
ARG KHIPU_GID=2000
ARG KHIPU_UID=2000
ARG ETCD_UID=2002
ARG ETCD_GID=2002

ADD developers@khipu.com-55de074c.rsa.pub /etc/apk/keys/
RUN echo "https://s3.amazonaws.com/alpine.khipu.com/packages/main" >> /etc/apk/repositories \
    && apk add --update curl tzdata bash gettext \
    && rm -rf /var/cache/apk/*

RUN cp /usr/share/zoneinfo/America/Santiago /etc/localtime \
    && echo "America/Santiago" > /etc/timezone \
    && addgroup -g ${ETCD_GID} -S etcd \
    && adduser -u ${ETCD_UID} -G etcd -S etcd \
    && addgroup -g ${KHIPU_GID} -S khipu \
    && adduser -u ${KHIPU_UID} -G khipu -G etcd -S khipu \
    && mkdir -p /opt/khipu \
    && cd /opt/khipu \
    && mkdir bin etc share log var \
    && chown -R khipu:khipu /opt/khipu

RUN curl -o /usr/local/bin/confd -sSL https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 \
    && chmod +x /usr/local/bin/confd \
    && curl -o etcd-v${ETCD_VERSION}-linux-amd64.tar.gz -sSL https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz \
    && tar xzf etcd-v${ETCD_VERSION}-linux-amd64.tar.gz \
    && mv etcd-v${ETCD_VERSION}-linux-amd64/etcdctl /usr/local/bin \
    && rm -Rf etcd-v${ETCD_VERSION}-linux-amd64/ etcd-v${ETCD_VERSION}-linux-amd64.tar.gz \
    && curl -o /usr/local/bin/gosu -fsSL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64 \
    && chmod +x /usr/local/bin/gosu
