#!/usr/bin/env bash

service postfix start
service dovecot start
service rsyslog start
service opendkim start

while ! tail -f /var/log/mail.log ; do echo "Waiting for log file"; sleep 1 ; done
tail -f /var/log/mail.log
