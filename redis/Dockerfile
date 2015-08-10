FROM redis:3.0
MAINTAINER developers@khipu.com

RUN echo 'America/Santiago' > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN usermod --uid 2000 redis && groupmod --gid 2000 redis
