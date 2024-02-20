#!/bin/bash

clear

# cd "$(dirname "$0")"

# Include configuration
. "/DockerLNMP/config.sh"

# Define colors and styles using tput
BOLD=$(tput bold)
GRAY=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
PURPLE=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)

RESET=$(tput sgr0)

# Define menu options
options=(
    "${BOLD}${PURPLE} Nginx >> ${RESET}"
    "${BOLD}${PURPLE} MariaDB >> ${RESET}"
    "${BOLD}${PURPLE} PHP >> ${RESET}"
    "${BOLD}${PURPLE} Redis >> ${RESET}"
    "${BOLD}${PURPLE} phpMyAdmin >> ${RESET}\n"
    
    "${BOLD}${PURPLE} 返回上一级 [Docker LNMP] ${RESET}\n"
)

function show_service_menu() {
    echo -e "${BOLD}${PURPLE}======== 服务 ========${RESET}\n"
    for i in "${!options[@]}"; do
        if [[ $i -eq $(( ${#options[@]} - 1 )) ]]; then
            echo -e "${BOLD}${RED}b. ${options[$i]}${RESET}"  # b 返回选项
        else
            echo -e "${BOLD}${BLUE}$((i+1)). ${options[$i]}${RESET}"
        fi
    done
}

# Handle user choice
function service_options() {
    read -p "${BOLD}${BLUE} 请输入选项编号: ${RESET}" choice
    echo "DEBUG: User input is $choice"  # debug
    case $choice in
        1)
            clear
            echo -e "${BOLD}${YELLOW} Nginx ${RESET}"
            "$NGINX_SERVER_SCRIPT_PATH"
        ;;
        2)
            clear
            echo -e "${BOLD}${YELLOW} MariaDB ${RESET}"
            "$MYSQL_SERVER_SCRIPT_PATH"
        ;;
        3)
            clear
            echo -e "${BOLD}${YELLOW} PHP ${RESET}"
            "$PHP_SERVER_SCRIPT_PATH"
        ;;
        4)
            clear
            echo -e "${BOLD}${YELLOW} Redis ${RESET}"
            "$REDIS_SERVER_SCRIPT_PATH"
        ;;
        5)
            clear
            echo -e "${BOLD}${YELLOW} phpMyAdmin ${RESET}"
            "$PHPMYADMIN_SERVER_SCRIPT_PATH"
        ;;
        B|b)
            clear
            echo -e "${BOLD}${YELLOW} Docker LNMP ${RESET}"
        ;;
        *)
            clear
            echo -e "${BOLD}${RED} 无效选项，请重新选择 ${RESET}"
        ;;
    esac
}

while true; do
    show_service_menu
    service_options
    # if [[ $choice == "m" || $choice == "M" ]]; then
    #     break
    # fi
done
