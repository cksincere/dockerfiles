FROM khipu/base-ubuntu:latest
MAINTAINER developers@khipu.com

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install curl s3cmd unzip wget -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget -nv https://s3.amazonaws.com/deb.khipu.com/khipux/khipu-base_0.0.2-5_amd64.deb && \
    dpkg -i khipu-base_0.0.2-5_amd64.deb && rm khipu-base_0.0.2-5_amd64.deb

ADD custom-certs /usr/share/ca-certificates/custom-certs
RUN chown root:root /usr/share/ca-certificates/custom-certs && \
    cd /usr/share/ca-certificates && \
    find custom-certs -type f >> /etc/ca-certificates.conf && \
    update-ca-certificates -f

RUN wget -nv https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 -O /usr/local/bin/confd && \
    chmod +x /usr/local/bin/confd

RUN wget -nv https://github.com/coreos/etcd/releases/download/v2.1.1/etcd-v2.1.1-linux-amd64.tar.gz && \
    tar xf etcd-v2.1.1-linux-amd64.tar.gz && \
    mv etcd-v2.1.1-linux-amd64/etcdctl /usr/local/bin && \
    rm -Rf etcd-v2.1.1-linux-amd64/ etcd-v2.1.1-linux-amd64.tar.gz
