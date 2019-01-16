FROM debian:latest

ARG domain
ARG user
ARG password

## Install Postfix + Dovecot
RUN echo mail > /etc/hostname

RUN echo "127.0.0.1 localhost mail mail.${domain}" > /etc/hosts \
 && chown root:root /etc/hosts

RUN echo "postfix postfix/main_mailer_type string Internet site" > postfix_silent_install.txt \
 && echo "postfix postfix/mailname string mail.${domain}" >> postfix_silent_install.txt \
 && debconf-set-selections postfix_silent_install.txt

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt install -q -y \
 postfix \
 dovecot-common \
 dovecot-imapd \
 dovecot-pop3d \
 vim \
 rsyslog

RUN useradd -m -d /home/${user} -s /bin/false -p ${password} ${user} \
 && echo "${user}:${password}" | chpasswd \
 && echo "root: ${user}" >> /etc/aliases \
 && newaliases

ADD ./config/main.cf /etc/postfix/main.cf
RUN postconf -e "myhostname = mail.${domain}" \
 && postconf -e "mydestination = mail.${domain}, ${domain}, localhost.localdomain, localhost"

ADD ./config/dovecot.conf /etc/dovecot/dovecot.conf

RUN service postfix stop ; service dovecot stop

## Install openDKIM

RUN apt install -y opendkim opendkim-tools
COPY ./config/opendkim.conf /etc/opendkim.conf

RUN echo SOCKET="inet:12301@localhost" >> /etc/default/opendkim
RUN mkdir /etc/opendkim \
 && mkdir /etc/opendkim/keys

COPY ./config/TrustedHosts /etc/opendkim/TrustedHosts
COPY ./config/KeyTable /etc/opendkim/KeyTable
COPY ./config/SigningTable /etc/opendkim/SigningTable

RUN mkdir -p /etc/opendkim/keys/rucreditor.ru
RUN cd /etc/opendkim/keys/rucreditor.ru \
 && opendkim-genkey -s mail -d rucreditor.ru \
 && chown opendkim:opendkim mail.private

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh