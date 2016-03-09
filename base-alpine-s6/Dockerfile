# based on https://github.com/just-containers/base-alpine.git
FROM khipu/base-alpine
MAINTAINER developers@khipu.com

##
## ROOTFS
##

# root filesystem
COPY rootfs /

# provide exec permission to basic utils
RUN chmod 0755 /sbin/apk-install

# s6 overlay
RUN curl -ssL https://github.com/just-containers/s6-overlay/releases/download/v1.17.1.1/s6-overlay-amd64.tar.gz -o /tmp/s6-overlay.tar.gz \
 && tar xvfz /tmp/s6-overlay.tar.gz -C / \
 && rm -f /tmp/s6-overlay.tar.gz \

##
## INIT
##

ENTRYPOINT [ "/init" ]
