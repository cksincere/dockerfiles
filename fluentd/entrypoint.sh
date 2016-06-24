#!/bin/bash

: ${KHIPU_ENV:?"must be set"}
: ${ETCD_PEERS:?"must be set"}
: ${KHIPU_HOME:?"must be set"}
: ${FLUENTD_OPT:?"must be set"}

CERTDIR=/etc/etcd/certs

echo "Starting fluentd env:${KHIPU_ENV} etcd:${ETCD_PEERS}"


if [ -f ${CERTDIR}/client.pem ] && [ -f ${CERTDIR}/client-key.pem ] && [ -f ${CERTDIR}/ca.pem ]; then
    confd -onetime -backend etcd -node https://${ETCD_PEERS} -scheme https -client-cert $CERTDIR/client.pem \
          -client-key $CERTDIR/client-key.pem  -prefix="/khipu/${KHIPU_ENV}/fluentd" -confdir ${KHIPU_HOME}/etc/confd || exit 1
else
    confd -onetime -backend etcd -node http://${ETCD_PEERS} -prefix="/khipu/${KHIPU_ENV}/fluentd" -confdir ${KHIPU_HOME}/etc/confd || exit 1
fi


chown -R khipu:khipu /fluentd && sync

exec su-exec khipu fluentd -c /fluentd/etc/fluentd.conf -p /fluentd/plugins ${FLUENTD_OPT} $@
