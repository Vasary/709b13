#!/usr/bin/env bash

mkdir -p /etc/opendkim/keys/rucreditor.ru
opendkim-genkey -s mail -d rucreditor.ru -D /etc/opendkim/keys/rucreditor.ru
chown opendkim:opendkim /etc/opendkim/keys/rucreditor.ru/mail.private