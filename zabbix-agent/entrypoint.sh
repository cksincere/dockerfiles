#!/bin/sh

if [ "$#" -ne 3 ]; then
    echo "entrypoint.sh <env> <etcd addr:port> <zabbix hostname>"
    exit 1
fi

KHENV=$1
ETCD_NODE=$2
export ZABBIX_HOSTNAME=$3

confd -onetime -backend etcd -node "$ETCD_NODE"  -prefix="/khipu/$KHENV/" -confdir /etc/confd || exit 1

exec /init
