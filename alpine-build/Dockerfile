FROM alpine:3.3

RUN apk -U add sudo alpine-sdk bash && \
    adduser -u 1000 -D khipu && \
    echo "khipu ALL=(ALL) ALL" >> /etc/sudoers && \
    mkdir -p /var/cache/distfiles && \
    chmod a+w /var/cache/distfiles && \
    addgroup khipu abuild && \
    chgrp abuild /var/cache/distfiles && \
    chmod g+w /var/cache/distfiles
