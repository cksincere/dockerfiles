FROM ubuntu:16.04
MAINTAINER developers@khipu.com

RUN apt-get update && apt-get install -y sudo openssh-server vim zsh git wget curl python-pip gnupg2 libssl-dev libffi-dev \
    && mkdir /var/run/sshd \
    && pip install pyyaml jinja2 nose passlib pycrypto ansible

ADD docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
