#!/bin/bash

clear

# Enter the directory where the script is located
cd "$(dirname "$0")"

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
    "${BOLD}${BLUE} Nginx >> ${RESET}"
    "${BOLD}${BLUE} MariaDB >> ${RESET}"
    "${BOLD}${BLUE} PHP >> ${RESET}"
    "${BOLD}${BLUE} Redis >> ${RESET}"
    "${BOLD}${BLUE} phpMyAdmin >> ${RESET}\n"
    
    "${BOLD}${WHITE} 返回上一级 [Docker LNMP] ${RESET}\n"
)

function show_containers_service_menu() {
    echo -e "${BOLD}${BLUE}======== 容器服务 ========${RESET}\n"
    for i in "${!options[@]}"; do
        if [[ $i -eq $(( ${#options[@]} - 1 )) ]]; then
            echo -e "${BOLD}${WHITE}b. ${options[$i]}${RESET}"  # b back
        else
            echo -e "${BOLD}${BLUE}$((i+1)). ${options[$i]}${RESET}"
        fi
    done
}

# Handle user choice
function containers_service_menu_options() {
    read -p "${BOLD}${BLUE} 请输入选项编号: ${RESET}" choice
    echo "DEBUG: User input is $choice"  # debug
    case $choice in
        1)
            clear
            echo -e "${BOLD}${YELLOW} Nginx ${RESET}"
            "$NGINX_MENU_LIST_SCRIPT_PATH"
        ;;
        2)
            clear
            echo -e "${BOLD}${YELLOW} MariaDB ${RESET}"
            "$MYSQL_MENU_LIST_SCRIPT_PATH"
        ;;
        3)
            clear
            echo -e "${BOLD}${YELLOW} PHP ${RESET}"
            "$PHP_MENU_LIST_SCRIPT_PATH"
        ;;
        4)
            clear
            echo -e "${BOLD}${YELLOW} Redis ${RESET}"
            "$REDIS_MENU_LIST_SCRIPT_PATH"
        ;;
        5)
            clear
            echo -e "${BOLD}${YELLOW} phpMyAdmin ${RESET}"
            "$PHPMYADMIN_MENU_LIST_SCRIPT_PATH"
        ;;
        B|b)
            clear
            echo -e "${BOLD}${WHITE} 返回上一级 [Docker LNMP] ${RESET}"
        ;;
        *)
            clear
            echo -e "${BOLD}${RED} 无效选项，请重新选择 ${RESET}"
        ;;
    esac
}

while true; do
    show_containers_service_menu
    containers_service_menu_options
    if [[ $choice == "b" || $choice == "B" ]]; then
        break
    fi
done
