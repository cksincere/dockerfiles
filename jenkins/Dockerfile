FROM jenkins:latest
MAINTAINER developers@khipu.com

USER root

RUN echo 'America/Santiago' > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y thrift-compiler && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    groupmod -g 2001 jenkins && \
    usermod -u 2001 -g 2001 jenkins

USER jenkins