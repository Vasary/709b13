#!/usr/bin/env bash

sh -c "service postfix start ; service dovecot start ; service rsyslog start ; service opendkim start; tail -f /dev/null"