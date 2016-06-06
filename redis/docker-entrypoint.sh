#!/bin/sh
set -e

: ${KHIPU_ENV:?"must be set"}
: ${ETCD_PEERS:?"must be set"}

MODE=""

case "$1" in
    redis-master)
        MODE=master
        ;;
    redis-slave)
        MODE=slave
        ;;
    redis-sentinel)
        MODE=sentinel
        ;;
    *)
        echo "mode not specified: redis-master|redis-slave|redis-sentinel"
        exit 1
        ;;
esac

shift

if [ ! -f /etc/redis.conf ]; then
    CERTDIR=/etc/etcd/certs
    PREFIX="/khipu/${KHIPU_ENV}/redis/${MODE}/"

    if [ -f ${CERTDIR}/client.pem ] && [ -f ${CERTDIR}/client-key.pem ] && [ -f  ${CERTDIR}/ca.pem ]; then
        confd -log-level debug -onetime -backend etcd -node https://${ETCD_PEERS} -scheme https -client-cert $CERTDIR/client.pem -client-key $CERTDIR/client-key.pem -prefix=${PREFIX}
    else
        confd -log-level debug -onetime -backend etcd -node http://${ETCD_PEERS} -prefix=${PREFIX}
    fi
    chown khipu:khipu /etc/redis.conf
fi

case "$MODE" in
    master|slave)
        exec su-exec khipu redis-server /etc/redis.conf "$@"
        ;;
    sentinel)
        exec su-exec khipu redis-server /etc/redis.conf --sentinel "$@"
        ;;
esac
