#!/bin/sh

if [ "$#" -ne 2 ]; then
    echo "entrypoint.sh <env> <etcd addr:port>"
    exit 1
fi

KHENV=$1
ETCD_NODE=$2

confd -onetime -backend etcd -node "$ETCD_NODE"  -prefix="/khipu/$KHENV/" -confdir /etc/confd || exit 1

exec /init
