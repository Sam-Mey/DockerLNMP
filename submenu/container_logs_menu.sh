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
    "${BOLD}${PURPLE} 查看 Nginx 日志 ${RESET}"
    "${BOLD}${PURPLE} 查看 MariaDB 日志 ${RESET}"
    "${BOLD}${PURPLE} 查看 PHP 日志 ${RESET}"
    "${BOLD}${PURPLE} 查看 Redis 日志 ${RESET}"
    "${BOLD}${PURPLE} 查看 phpMyAdmin 日志 ${RESET}\n"
    "${BOLD}${RED} 上一级菜单 [Docker LNMP] ${RESET}"
)

# Show 替换为实际名称
function show_check_container_logs_menu() {
    echo -e "${BOLD}${PURPLE}======== 查看容器日志 ========${RESET}\n" # 换为实际名称
    for i in "${!options[@]}"; do
        if [[ $i -eq $(( ${#options[@]} - 1 )) ]]; then
            echo -e "${BOLD}${RED}m. ${options[$i]}${RESET}\n"  # 将返回选项标记为红色
        else
            echo -e "${BOLD}${PURPLE}$((i+1)). ${options[$i]}${RESET}"
        fi
    done
}

# Handle user choice
function handle_choice() {
    read -p "${BOLD}${BLUE} 请输入选项编号: ${RESET}" choice
    # 1-1 菜单
    case $choice in
        1)
            clear
            echo -e "${BOLD}${YELLOW} Nginx 日志 ${RESET}"
            docker logs server-nginx-1
        ;;
        2)
            clear
            echo -e "${BOLD}${YELLOW} MariaDB 日志 ${RESET}"
            docker logs server-mariadb-1
        ;;
        3)
            clear
            echo -e "${BOLD}${YELLOW}PHP 日志 ${RESET}"
            docker logs server-php-1
        ;;
        4)
            clear
            echo -e "${BOLD}${YELLOW} Redis 日志 ${RESET}"
            docker logs server-redis-1
        ;;
        5)
            clear
            echo -e "${BOLD}${YELLOW} phpMyAdmin 日志 ${RESET}"
            docker logs server-phpmyadmin-1
        ;;
        M|m)
            clear
            echo "${BOLD}${RED} [Docker LNMP] 菜单 ${RESET}"
        ;;
        *)
            clear
            echo -e "${BOLD}${RED} 无效选项，请重新选择 ${RESET}"
        ;;
    esac
}

# 主循环
while true; do
    show_check_container_logs_menu # 换为实际名称
    handle_choice
    if [[ $choice == "m" || $choice == "M" ]]; then
        break  # 退出循环，返回到调用的主菜单
    fi
done
