#!/bin/sh
set -e

: ${KHIPU_ENV:?"must be set"}
: ${ETCD_PEERS:?"must be set"}
: ${ZABBIX_HOSTNAME:?"must be set"}

exec /init $@
