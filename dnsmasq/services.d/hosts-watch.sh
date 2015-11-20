#!/bin/sh

while true; do
    inotifywait -qq -e modify /etc/hosts
    s6-svc -h /var/run/s6/services/dnsmasq
done
