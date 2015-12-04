#!/bin/bash -e

# Reduce maximum number of number of open file descriptors to 1024
# otherwise slapd consumes two orders of magnitude more of RAM
# see https://github.com/docker/docker/issues/8231
ulimit -n 1024

AH=""
if [ ! -z "$ALTERNATIVE_HOSTNAME" ]; then
    AH="ldap://$ALTERNATIVE_HOSTNAME ldaps://$ALTERNATIVE_HOSTNAME"
fi

exec /usr/sbin/slapd -h "$AH ldap://$HOSTNAME ldaps://$HOSTNAME ldap://localhost ldaps://localhost ldapi:///" -u openldap -g openldap -d $LDAP_LOG_LEVEL
