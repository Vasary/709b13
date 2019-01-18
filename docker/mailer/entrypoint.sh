#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

service rsyslog start

echo -e "\n"
/scripts/setup.sh
echo -e "\n"
/scripts/generate_opendkim_keys.sh
echo -e "\n"
/scripts/add_allias.sh $ALIASES

echo -e "\nApplying aliases list"
newaliases

if [[ -f /var/spool/postfix/pid/master.pid ]]; then
    if rm /var/spool/postfix/pid/master.pid; then
        printf "${NC}[ ${GREEN}ok ${NC}] Remove postfix master.pid\n"
    else
        printf "${NC}[ ${RED}error ${NC}] Remove postfix master.pid\n"
    fi
fi

echo -e "\nStarting services\n"
service postfix start
service dovecot start
service opendkim start

sleep 1

echo -e "\nStatuses\n"
service postfix status
service dovecot status
service opendkim status

echo -e "\n"
echo "QUIT" | nc localhost 25
echo -e "\n"

netstat -plnt

echo -e "\n"

sleep 1

tail -fn50 /var/log/syslog
