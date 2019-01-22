#!/usr/bin/env bash

cat << 'EOF'
/***
 *     ______     ______     ______   __  __     ______
 *    /\  ___\   /\  ___\   /\__  _\ /\ \/\ \   /\  == \
 *    \ \___  \  \ \  __\   \/_/\ \/ \ \ \_\ \  \ \  _-/
 *     \/\_____\  \ \_____\    \ \_\  \ \_____\  \ \_\
 *      \/_____/   \/_____/     \/_/   \/_____/   \/_/
 *
 */
EOF

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "\nCurrent domain: ${DOMAIN}\n"

if [[ -f /var/spool/postfix/pid/master.pid ]]; then
    if rm /var/spool/postfix/pid/master.pid; then
        printf "${NC}[ ${GREEN}ok ${NC}] Remove master.pid\n"
    else
        printf "${NC}[ ${RED}error ${NC}] Remove master.pid\n"
    fi
fi

if echo mail > /etc/hostname; then
    printf "${NC}[ ${GREEN}ok ${NC}] Setup hostname\n"
else
    printf "${NC}[ ${RED}error ${NC}] Setup hostname\n"
fi

if echo "127.0.0.1 localhost mail mail.${DOMAIN}" > /etc/hosts; then
    printf "${NC}[ ${GREEN}ok ${NC}] Setup hosts\n"
else
    printf "${NC}[ ${RED}error ${NC}] Setup hosts\n"
fi

if chown root:root /etc/hosts; then
    printf "${NC}[ ${GREEN}ok ${NC}] Setup chown\n"
else
    printf "${NC}[ ${RED}error ${NC}] Setup chown\n"
fi

if echo SOCKET="inet:12301@localhost" >> /etc/default/opendkim; then
    printf "${NC}[ ${GREEN}ok ${NC}] Setup openDKIM socket\n"
else
    printf "${NC}[ ${RED}error ${NC}] Setup openDKIM socket\n"
fi

array=(
    "/etc/postfix/main.cf"
    "/etc/opendkim/TrustedHosts"
    "/etc/opendkim/KeyTable"
    "/etc/opendkim/SigningTable"
    "/etc/mailname"
)
for i in "${array[@]}"
do
	if sed -i "s/{domain}/${DOMAIN}/gi" ${i}; then
        printf "${NC}[ ${GREEN}ok ${NC}] Updating: ${i}\n"
    else
        printf "${NC}[ ${RED}error ${NC}] Updating: ${i}\n"
    fi
done
