#!/bin/bash

set -e

: ${KHIPU_ENV:?"must be set"}
: ${ETCD_PEERS:?"must be set"}
: ${NODE_CLUSTER:?"must be set"}
: ${NODE_ID:?"must be set"}
: ${PGDATA:=/var/lib/postgres/data}
: ${IFACE:=eth0}

export ETCDCTL_PEERS=https://`echo $ETCD_PEERS | cut -d"," -f1`
export ETCDCTL_CA_FILE=/etc/etcd/certs/ca.pem
export ETCDCTL_KEY_FILE=/etc/etcd/certs/client-key.pem
export ETCDCTL_CERT_FILE=/etc/etcd/certs/client.pem
export IP_ADDR=`ip addr s $IFACE | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/'`

confd -log-level debug -onetime -backend env
eval `etcdctl get /khipu/$KHIPU_ENV/pgbouncer/databases/$NODE_CLUSTER`

: ${host:?"invalid conninfo"}
: ${port:?"invalid conninfo"}

if [ ! -s "$PGDATA/PG_VERSION" ]; then
    echo -e "\nInitializing witness cluster\n\n"
    su-exec postgres ssh-keyscan $host > /var/lib/postgresql/.ssh/known_hosts
    su-exec postgres repmgr --initdb-no-pwprompt -L DEBUG -d repmgr -U repmgr -h $host -p $port -D $PGDATA -f /etc/repmgr/repmgr.conf witness create
    su-exec postgres pg_ctl -D $PGDATA stop
    echo -e "\nInitialization complete\n\n"
fi

exec /init $@
