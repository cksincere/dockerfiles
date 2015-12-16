#!/bin/sh

if [ "$#" -ne 2 ]; then
    echo "entrypoint.sh <env> <etcd addr:port>"
    exit 1
fi

KHENV=$1
ETCD_NODE=$2

if [ -f /etc/etcd/certs/client.pem ] && [ -f /etc/etcd/certs/client-key.pem ] && [ -f /etc/etcd/certs/ca.pem ]; then
    confd -onetime -backend etcd -node https://"$ETCD_NODE" -scheme https -client-cert /etc/etcd/certs/client.pem \
          -client-key /etc/etcd/certs/client-key.pem  -prefix="/khipu/$KHENV/" -confdir /etc/confd || exit 1
else
    confd -onetime -backend etcd -node http://"$ETCD_NODE" -prefix="/khipu/$KHENV/" -confdir /etc/confd || exit 1
fi

exec /init
