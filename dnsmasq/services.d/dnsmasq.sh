#!/bin/sh

exec dnsmasq -k --cache-size=500 --dns-forward-max=1000
