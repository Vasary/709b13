#!/usr/bin/env bash

cat << 'EOF'

/***
 *     ______     ______   ______     __   __     _____     __  __     __     __    __    
 *    /\  __ \   /\  == \ /\  ___\   /\ "-.\ \   /\  __-.  /\ \/ /    /\ \   /\ "-./  \   
 *    \ \ \/\ \  \ \  _-/ \ \  __\   \ \ \-.  \  \ \ \/\ \ \ \  _"-.  \ \ \  \ \ \-./\ \  
 *     \ \_____\  \ \_\    \ \_____\  \ \_\\"\_\  \ \____-  \ \_\ \_\  \ \_\  \ \_\ \ \_\ 
 *      \/_____/   \/_/     \/_____/   \/_/ \/_/   \/____/   \/_/\/_/   \/_/   \/_/  \/_/ 
 *                                                                                        
 */
EOF

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "\nGenerating DKIM key for domain: ${DOMAIN}"

if mkdir -p /etc/opendkim/keys/${DOMAIN}; then
    printf "${NC}[ ${GREEN}ok ${NC}] Directories\n"
else
    printf "${NC}[ ${RED}error ${NC}] Directories\n"
fi

echo -e "\nCheck keys for exists"

if [[ -f /etc/opendkim/keys/${DOMAIN}/mail.private ]] && [[ -f /etc/opendkim/keys/${DOMAIN}/mail.txt ]]; then
    printf "${NC}[ ${GREEN}ok ${NC}] Keys already exists\n"
    exit;
fi

if opendkim-genkey -s mail -d ${DOMAIN} -D /etc/opendkim/keys/${DOMAIN}; then
    printf "${NC}[ ${GREEN}ok ${NC}] Generating keys\n"
else
    printf "${NC}[ ${RED}error ${NC}] Generating keys\n"
fi

if chown opendkim:opendkim /etc/opendkim/keys/${DOMAIN}/mail.private; then
    printf "${NC}[ ${GREEN}ok ${NC}] Chown\n"
else
    printf "${NC}[ ${RED}error ${NC}] Chown\n"
fi

echo -e "\nZone record template:"
cat /etc/opendkim/keys/${DOMAIN}/mail.txt

echo -e "\n"