#!/usr/bin/with-contenv sh

CERTDIR=/etc/etcd/certs
PREFIX="/khipu/${KHIPU_ENV}/"

CONFD_INTERVAL=${CONFD_INTERVAL:-"10"}
CONFD_LOGLEVEL=${CONFD_LOGLEVEL:-"info"}

exec /usr/local/bin/confd -log-level ${CONFD_LOGLEVEL} -interval ${CONFD_INTERVAL} -backend etcd -node https://${ETCD_PEERS} -scheme https -client-cert ${CERTDIR}/client.pem -client-key ${CERTDIR}/client-key.pem -prefix=${PREFIX}
