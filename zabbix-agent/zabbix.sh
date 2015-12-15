#!/usr/bin/with-contenv sh

exec s6-setuidgid zabbix zabbix_agentd -f -c /etc/zabbix/zabbix_agentd.conf
