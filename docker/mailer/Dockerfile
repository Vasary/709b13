FROM debian:9

RUN apt update \
 && apt upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt install -q -y \
 postfix \
 dovecot-common \
 dovecot-imapd \
 dovecot-pop3d \
 vim \
 rsyslog \
 opendkim \
 opendkim-tools \
 procps \
 telnet \
 netcat \
 net-tools

RUN mkdir /etc/opendkim \
 && mkdir /etc/opendkim/keys

COPY ./config/postfix/main.cf /etc/postfix/main.cf
COPY ./config/postfix/mailname /etc/mailname
COPY ./config/postfix/aliases /etc/postfix/aliases
COPY ./config/dovecot/dovecot.conf /etc/dovecot/dovecot.conf
COPY ./config/dkim/conf/opendkim.conf /etc/opendkim.conf
COPY ./config/dkim/tables/TrustedHosts /etc/opendkim/TrustedHosts
COPY ./config/dkim/tables/KeyTable /etc/opendkim/KeyTable
COPY ./config/dkim/tables/SigningTable /etc/opendkim/SigningTable
COPY ./scripts /scripts

RUN chmod +x -R /scripts
RUN touch /var/log/mail.log

WORKDIR /scripts

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
