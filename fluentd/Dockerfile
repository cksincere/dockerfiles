FROM khipu/base-alpine
MAINTAINER developers@khipu.com

# Do not split this into multiple RUN!
# Docker creates a layer for every RUN-Statement
# therefore an 'apk delete build*' has no effect
RUN apk --no-cache --update add \
                            build-base \
                            ca-certificates \
                            ruby \
                            ruby-irb \
                            ruby-dev && \
    echo 'gem: --no-document' >> /etc/gemrc && \
    gem install oj && \
    gem install fluentd -v 0.12.26 && \
    apk del build-base ruby-dev && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

RUN adduser -D -g '' -u 2000 -h /home/khipu khipu
RUN chown -R khipu:khipu /home/khipu

# for log storage (maybe shared with host)
RUN mkdir -p /fluentd/log
# configuration/plugins path (default: copied from .)
RUN mkdir -p /fluentd/etc /fluentd/plugins

RUN chown -R khipu:khipu /fluentd

USER khipu
WORKDIR /home/khipu

# Tell ruby to install packages as user
RUN echo "gem: --user-install --no-document" >> ~/.gemrc
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH
ENV GEM_PATH /home/fluent/.gem/ruby/2.3.0:$GEM_PATH

RUN gem install fluent-plugin-secure-forward

COPY fluent.conf /fluentd/etc/

COPY entrypoint.sh /
COPY confd ${KHIPU_HOME}/etc/confd

ENTRYPOINT ["/entrypoint.sh"]


