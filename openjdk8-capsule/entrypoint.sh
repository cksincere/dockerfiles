#!/bin/bash

: ${KHIPU_ENV:?"must be set"}
: ${ETCD_PEERS:?"must be set"}
: ${KHIPU_HOME:?"must be set"}
: ${ZABBIX_HOSTNAME:?"must be set"}

if [ -n "$DOCKER_GID" ]; then
    if [ ! $(getent group docker) ]; then
        addgroup -g $DOCKER_GID -S docker
        adduser khipu docker
    fi
fi

CERTDIR=/etc/etcd/certs

echo "Starting ${PROJECT_NAME} ${PROJECT_VERSION} env:${KHIPU_ENV} etcd:${ETCD_PEERS} prefix:${PROJECT_PREFIX}"

PREFIX="${KHIPU_ENV}"

if [ ! -z ${PROJECT_PREFIX+x} ]; then
    PREFIX="${PREFIX}/${PROJECT_PREFIX}"
fi

if [ ! -z ${DEBUG+x}  ]; then
    echo "Activating debug"
    JAVA_OPTS="-Dcapsule.jvm.args=-agentlib:jdwp=transport=dt_socket,address=8787,server=y,suspend=n"
fi

find ${KHIPU_HOME}/etc/confd/conf.d -type f -name "*.shtmpl" | while read f; do
  envsubst < $f > ${f/.shtmpl/}
done

if [ -f ${CERTDIR}/client.pem ] && [ -f ${CERTDIR}/client-key.pem ] && [ -f ${CERTDIR}/ca.pem ]; then
    confd -onetime -backend etcd -node https://${ETCD_PEERS} -scheme https -client-cert $CERTDIR/client.pem \
          -client-key $CERTDIR/client-key.pem  -prefix="/khipu/${PREFIX}/" -confdir ${KHIPU_HOME}/etc/confd || exit 1
else
    confd -onetime -backend etcd -node http://${ETCD_PEERS} -prefix="/khipu/${PREFIX}/" -confdir ${KHIPU_HOME}/etc/confd || exit 1
fi

cd ${KHIPU_HOME}
exec gosu khipu java ${JAVA_OPTS} -jar ${KHIPU_HOME}/share/${PROJECT_NAME}/${PROJECT_NAME}-capsule.jar $@
