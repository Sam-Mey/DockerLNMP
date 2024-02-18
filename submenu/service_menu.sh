#!/bin/bash

clear

# 进入脚本所在目录
cd "$(dirname "$0")"

# 保存脚本所在目录的路径
SCRIPT_DIR="/DockerLNMP/lnmp" # 换为实际名称

# 引入配置
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

# Show 替换为实际名称
function show_service_menu() {
    echo -e "${BOLD}${PURPLE}======== 服务 ========${RESET}\n" # 换为实际名称
    for i in "${!options[@]}"; do
        if [[ $i -eq $(( ${#options[@]} - 1 )) ]]; then
            echo -e "${BOLD}${RED}m. ${options[$i]}${RESET}"  # q 返回选项
        else
            echo -e "${BOLD}${BLUE}$((i+1)). ${options[$i]}${RESET}"
        fi
    done
}

# Handle user choice
function service_options() {
    read -p "${BOLD}${BLUE} 请输入选项编号: ${RESET}" choice
    case $choice in
        1)
            clear
            echo -e "${BOLD}${YELLOW} Nginx ${RESET}"
            "$NGINX_MENU_SCRIPT_PATH"
        ;;
        2)
            clear
            echo -e "${BOLD}${YELLOW} MariaDB ${RESET}"
            "$MYSQL_MENU_SCRIPT_PATH"
        ;;
        3)
            clear
            echo -e "${BOLD}${YELLOW} PHP ${RESET}"
            "$PHP_MENU_SCRIPT_PATH"
        ;;
        4)
            clear
            echo -e "${BOLD}${YELLOW} Redis ${RESET}"
            "$REDIS_MENU_SCRIPT_PATH"
        ;;
        5)
            clear
            echo -e "${BOLD}${YELLOW} phpMyAdmin ${RESET}"
            "$PHPMYADMIN_MENU_SCRIPT_PATH"
        ;;
        M|m)
            clear
            echo -e "${BOLD}${YELLOW} Docker LNMP ${RESET}"
        ;;
        *)
            clear
            echo -e "${BOLD}${RED} 无效选项，请重新选择 ${RESET}"
        ;;
    esac
}

# 主循环
while true; do
    show_service_menu # 换为实际名称
    service_options
    if [[ $choice == "m" || $choice == "M" ]]; then
        break  # 退出循环，返回到调用的主菜单
    fi
done


