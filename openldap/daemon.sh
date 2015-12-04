#!/bin/bash -e

# Reduce maximum number of number of open file descriptors to 1024
# otherwise slapd consumes two orders of magnitude more of RAM
# see https://github.com/docker/docker/issues/8231
ulimit -n 1024

HN=""
if [ ! -z "$LDAP_HOSTNAME" ]; then
    HN="ldap://$LDAP_HOSTNAME ldaps://$LDAP_HOSTNAME"
else
    HN="ldap://$HOSTNAME ldaps://$HOSTNAME"
fi

exec /usr/sbin/slapd -h "$HN ldap://localhost ldaps://localhost ldapi:///" -u openldap -g openldap -d $LDAP_LOG_LEVEL
