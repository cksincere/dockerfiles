FROM khipu/base-alpine
MAINTAINER developers@khipu.com

RUN apk -U add openjdk8

# jvm fixes
RUN curl -sSL https://s3.amazonaws.com/downloads.khipu.com/jvm/tzdata2016d/tzdb.dat -o /usr/lib/jvm/java-1.8-openjdk/jre/lib/tzdb.dat \
  && sed -i 's/.*networkaddress.cache.ttl=.*/networkaddress.cache.ttl=5/g' /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/java.security \
  && sed -i 's/.*networkaddress.cache.negative.ttl=.*/networkaddress.cache.negative.ttl=5/g' /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/java.security