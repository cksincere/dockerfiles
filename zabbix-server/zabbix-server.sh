#!/bin/sh
exec s6-setuidgid zabbix zabbix_server -f
