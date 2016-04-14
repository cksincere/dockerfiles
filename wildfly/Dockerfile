FROM khipu/base-alpine
MAINTAINER developers@khipu.com

ENV JAVA_VERSION 8u77
ENV JAVA_ALPINE_VERSION 8.77.03-r0
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

ENV WILDFLY_VERSION 10.0.0.Final
ENV WILDFLY_SHA1 c0dd7552c5207b0d116a9c25eb94d10b4f375549
ENV JBOSS_HOME /opt/wildfly

RUN apk add --no-cache openjdk8=${JAVA_ALPINE_VERSION}

RUN curl -O -sSL https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
    && tar xzf wildfly-$WILDFLY_VERSION.tar.gz \
    && mv wildfly-$WILDFLY_VERSION $JBOSS_HOME \
    && rm wildfly-$WILDFLY_VERSION.tar.gz \
    && chown -R khipu:khipu $JBOSS_HOME

ENV LAUNCH_JBOSS_IN_BACKGROUND true

EXPOSE 8080 9990

ENTRYPOINT ["gosu", "khipu", "/opt/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]