FROM jenkins:latest
MAINTAINER developers@khipu.com

USER root

RUN echo 'America/Santiago' > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y thrift-compiler \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && groupmod -g 2000 jenkins \
    && usermod -u 2000 -g 2000 jenkins

USER jenkins
