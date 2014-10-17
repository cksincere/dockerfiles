# BUILD-USING	sudo docker.io build -t khipu/memcached .
# RUN-USING	sudo docker.io run -d -h memcached1 --name memcached1 khipu/memcached

FROM khipu/base-ubuntu
MAINTAINER developers@khipu.com

RUN apt-get install -y memcached

USER daemon

CMD ["memcached", "-m", "128"]
