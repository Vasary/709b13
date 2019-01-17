#!/usr/bin/env bash

cat << 'EOF'

/***
 *     ______   ______     ______     ______   ______   __     __  __        ______     __         __     ______     ______    
 *    /\  == \ /\  __ \   /\  ___\   /\__  _\ /\  ___\ /\ \   /\_\_\_\      /\  __ \   /\ \       /\ \   /\  __ \   /\  ___\   
 *    \ \  _-/ \ \ \/\ \  \ \___  \  \/_/\ \/ \ \  __\ \ \ \  \/_/\_\/_     \ \  __ \  \ \ \____  \ \ \  \ \  __ \  \ \___  \  
 *     \ \_\    \ \_____\  \/\_____\    \ \_\  \ \_\    \ \_\   /\_\/\_\     \ \_\ \_\  \ \_____\  \ \_\  \ \_\ \_\  \/\_____\ 
 *      \/_/     \/_____/   \/_____/     \/_/   \/_/     \/_/   \/_/\/_/      \/_/\/_/   \/_____/   \/_/   \/_/\/_/   \/_____/ 
 *                                                                                                                             
 */
EOF

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "\n"

if (( $# == 0 )); then
    echo -e "\nEmpty alias set\n"
fi

for var in "$@"
do
    if [[ $(grep -o "${var}" /etc/aliases | wc -l) != 0 ]];then
        printf "${NC}[ ${RED}exists ${NC}] Alias: ${var}\n"
    else
        if echo "${var}: ${MAILER_USER}" >> /etc/aliases; then
            printf "${NC}[ ${GREEN}ok ${NC}] New alias: ${var}\n"
        else
            printf "${NC}[ ${RED}error ${NC}] New alias: ${var}\n"
        fi
    fi
done
