#!/usr/bin/with-contenv sh

while [ ! -s "$PGDATA/postmaster.pid" ]; do
    sleep 1
done

s6-setuidgid postgres repmgrd -v -f /etc/repmgr/repmgr.conf
