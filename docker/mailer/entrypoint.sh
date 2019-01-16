#!/usr/bin/env bash

service postfix start
service dovecot start
service rsyslog start
service opendkim start

while ! tail -fn50 /var/log/mail.log ; do echo "Waiting for log file"; sleep 1 ; done
