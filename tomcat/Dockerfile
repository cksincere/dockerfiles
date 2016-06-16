FROM khipu/base-alpine
MAINTAINER developers@khipu.com

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.0.36
ENV TOMCAT_SHA1 c711970918f4c0ebd120cf35605795c416e342c8
ENV TOMCAT_HOME /opt/tomcat

RUN apk add --no-cache openjdk8

# jvm fixes
RUN curl -sSL https://s3.amazonaws.com/downloads.khipu.com/jvm/tzdata2016d/tzdb.dat -o /usr/lib/jvm/java-1.8-openjdk/jre/lib/tzdb.dat \
  && sed -i 's/.*networkaddress.cache.ttl=.*/networkaddress.cache.ttl=5/g' /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/java.security \
  && sed -i 's/.*networkaddress.cache.negative.ttl=.*/networkaddress.cache.negative.ttl=5/g' /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/java.security

RUN curl -O -sSL https://archive.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz \
    && sha1sum apache-tomcat-$TOMCAT_VERSION.tar.gz | grep $TOMCAT_SHA1 \
    && tar xzf apache-tomcat-$TOMCAT_VERSION.tar.gz \
    && mv apache-tomcat-$TOMCAT_VERSION.tar.gz $TOMCAT_HOME \
    && rm apache-tomcat-$TOMCAT_VERSION.tar.gz \
    && rm -rf $TOMCAT_HOME\webapps\* \
    && chown -R khipu:khipu $TOMCAT_HOME

ENTRYPOINT ["su-exec", "khipu", "/opt/tomcat/bin/catalina.sh", "run"]
