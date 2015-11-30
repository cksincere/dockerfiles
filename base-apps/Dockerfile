FROM khipu/base-ubuntu:latest
MAINTAINER developers@khipu.com

ENV ETCD_VERSION=2.2.2

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install curl s3cmd unzip wget -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN groupadd -r -g 2000 khipu && \
    useradd -r -u 2000 -g 2000 -s /sbin/nologin khipu && \
    groupadd -r -g 2002 etcd && \
    useradd -r -u 2002 -g 2002 -s /sbin/nologin etcd && \
    gpasswd -a khipu etcd

ADD custom-certs /usr/share/ca-certificates/custom-certs
RUN chown root:root /usr/share/ca-certificates/custom-certs && \
    cd /usr/share/ca-certificates && \
    find custom-certs -type f >> /etc/ca-certificates.conf && \
    update-ca-certificates -f

RUN wget -nv https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 -O /usr/local/bin/confd && \
    chmod +x /usr/local/bin/confd

RUN wget -nv https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz && \
    tar xf etcd-v${ETCD_VERSION}-linux-amd64.tar.gz && \
    mv etcd-v${ETCD_VERSION}-linux-amd64/etcdctl /usr/local/bin && \
    rm -Rf etcd-v${ETCD_VERSION}-linux-amd64/ etcd-v${ETCD_VERSION}-linux-amd64.tar.gz
