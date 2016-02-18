FROM ubuntu:trusty
MAINTAINER developers@khipu.com

ENV ETCD_VERSION=2.2.5
ENV CONFD_VERSION=0.11.0

RUN echo 'America/Santiago' > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    dpkg-reconfigure --frontend noninteractive locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install curl s3cmd unzip wget -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN groupadd -r -g 2000 khipu && \
    useradd -r -u 2000 -g 2000 -s /sbin/nologin khipu && \
    groupadd -r -g 2002 etcd && \
    useradd -r -u 2002 -g 2002 -s /sbin/nologin etcd && \
    gpasswd -a khipu etcd

RUN wget -nv https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 -O /usr/local/bin/confd && \
    chmod +x /usr/local/bin/confd

RUN wget -nv https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz && \
    tar xf etcd-v${ETCD_VERSION}-linux-amd64.tar.gz && \
    mv etcd-v${ETCD_VERSION}-linux-amd64/etcdctl /usr/local/bin && \
    rm -Rf etcd-v${ETCD_VERSION}-linux-amd64/ etcd-v${ETCD_VERSION}-linux-amd64.tar.gz
