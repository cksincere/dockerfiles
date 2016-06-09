#!/usr/bin/with-contenv sh

while [ ! -f /etc/pgbouncer/pgbouncer.ini ]; do
    sleep 1
done

exec s6-setuidgid khipu /usr/bin/pgbouncer -v /etc/pgbouncer/pgbouncer.ini
