FROM kibana:5.1.1
MAINTAINER developers@khipu.com
RUN usermod --uid 2000 kibana && groupmod --gid 2000 kibana && \
    su - kibana -c "/usr/share/kibana/bin/kibana-plugin install x-pack"
