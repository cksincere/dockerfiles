# BUILD-WITH    sudo docker.io build -t khipu/cargo .
# RUN-WITH      sudo docker.io run -d -h cargo1 --name cargo1 khipu/cargo

FROM khipu/java7
MAINTAINER developers@khipu.com

RUN apt-get update
RUN apt-get install -y curl

RUN groupadd -r -g 2001 cargo && \
    useradd -m -r -u 2001 -g cargo -d /home/cargo -s /sbin/nologin -c "Cargo user" cargo

RUN mkdir -p /home/payment/logs && \
    touch /home/payment/logs/empty.txt && \
    chown -R cargo /home/payment/logs

USER cargo

WORKDIR /home/cargo

RUN curl http://repo1.maven.org/maven2/org/codehaus/cargo/cargo-daemon-webapp/1.4.10/cargo-daemon-webapp-1.4.10.war -o "cargo-daemon-webapp-1.4.10.war"

VOLUME ["/home/cargo", "/home/payment/logs"]

CMD ["java", "-Ddaemon.home=/home/cargo",  "-jar",  "cargo-daemon-webapp-1.4.10.war"]
