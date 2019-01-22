#!/usr/bin/env bash

cat << 'EOF'
/***
 *     __  __     ______     ______     ______     ______
 *    /\ \/\ \   /\  ___\   /\  ___\   /\  == \   /\  ___\
 *    \ \ \_\ \  \ \___  \  \ \  __\   \ \  __<   \ \___  \
 *     \ \_____\  \/\_____\  \ \_____\  \ \_\ \_\  \/\_____\
 *      \/_____/   \/_____/   \/_____/   \/_/ /_/   \/_____/
 *
 */
EOF

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "\nManage users:"

echo -e "\nFlushing aliases map"
cat /dev/null > /etc/postfix/aliases

cat /etc/users | while read line; do
    echo -e "\n"
    userData=(${line})

    name=${userData[0]}
    password=${userData[1]}
    alias="${userData[2]} ${name}@${DOMAIN}"

    if ! id -u ${name} > /dev/null 2>&1; then
        if useradd -m -d /home/${name} -s /bin/false -p ${password} ${name}; then
            printf "${NC}[ ${GREEN}ok ${NC}] Creating default user: ${name}, ${password}\n"
        else
            printf "${NC}[ ${RED}error ${NC}] Creating default user: ${name}, ${password}\n"
        fi
    fi

    echo -e "${password}\n${password}" | (passwd ${name}) &>/dev/null
    printf "${NC}[ ${GREEN}ok ${NC}] Updating ${name} password. Use this: ${password}\n"

    if echo ${alias} >> /etc/postfix/aliases; then
        printf "${NC}[ ${GREEN}ok ${NC}] Updating alias for ${name} to {$alias}\n"
    else
        printf "${NC}[ ${RED}error ${NC}] Updating alias for ${name} to {$alias}\n"
    fi
done

newaliases

echo -e "\n"
