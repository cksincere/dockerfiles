FROM khipu/base-ubuntu:latest
MAINTAINER developers@khipu.com

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install curl s3cmd -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl https://s3.amazonaws.com/deb.khipu.com/khipux/khipu-base_0.0.2-5_amd64.deb > /tmp/khipu-base_0.0.2-5_amd64.deb && \
    dpkg -i /tmp/khipu-base_0.0.2-5_amd64.deb && rm /tmp/khipu-base_0.0.2-5_amd64.deb

ADD custom-certs /usr/share/ca-certificates/custom-certs
RUN chown root:root /usr/share/ca-certificates/custom-certs && \
    cd /usr/share/ca-certificates && \
    find custom-certs -type f >> /etc/ca-certificates.conf && \
    update-ca-certificates -f

RUN curl -L https://github.com/kelseyhightower/confd/releases/download/v0.6.3/confd-0.6.3-linux-amd64 > /usr/local/bin/confd && \
    chmod +x /usr/local/bin/confd
