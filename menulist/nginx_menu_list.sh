#!/bin/bash

clear

# Enter the directory where the script is located
cd "$(dirname "$0")"

# Include configuration
. /DockerLNMP/config.sh

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

# Define nginx options
options=(
    "${BOLD}${BLUE} 查看配置文件 ${RESET}"
    "${BOLD}${BLUE} 查看日志 ${RESET}"
    "${BOLD}${BLUE} 运行状态 ${RESET}"
    "${BOLD}${BLUE} 重新加载 ${RESET}\n"
    
    "${BOLD}${WHITE} 返回上一级 ${RESET}\n"
)

# Show nginx
function show_nginx_menu_list() {
    echo -e "${BOLD}${BLUE}———————————————————————————————— Nginx 容器服务 —————————————————————————————————— ${RESET}\n"
    for i in "${!options[@]}"; do
        if [[ $i -eq $(( ${#options[@]} - 1 )) ]]; then
            echo -e "${BOLD}${WHITE}b. ${options[$i]}${RESET}"  # b back
        else
            echo -e "${BOLD}${BLUE}$((i+1)). ${options[$i]}${RESET}"
        fi
    done
}

# Handle user choice
function nginx_menu_list_options() {
    read -p "${BOLD}${BLUE} 请输入选项编号:${RESET}" choice
    echo "DEBUG: User input is $choice"  # debug
    case $choice in
        1)
            clear
            echo -e "${BOLD}${YELLOW} Nginx 配置文件 ${RESET}"
            "$CHECK_NGINX_CONF_SCRIPT_PATH"
        ;;
        2)
            clear
            echo -e "${BOLD}${YELLOW} Nginx 日志: ${RESET}"
            "$XXXXXX"
        ;;
        3)
            clear
            echo -e "${BOLD}${YELLOW} XXX ${RESET}"
            "$XXXXXX"
        ;;
        4)
            clear
            echo -e "${BOLD}${YELLOW} 正在加载 Nginx... ${RESET}"
            "$RESTART_NGINX_SCRIPT_PATH"
        ;;
        B|b)
            clear
            echo "${BOLD}${WHITE} 返回上一级 [容器服务] ${RESET}"
            exit 0
        ;;
        *)
            clear
            echo -e "${BOLD}${RED} 无效选项，请重新选择 ${RESET}"
        ;;
    esac
}

while true; do
    show_nginx_menu_list
    nginx_menu_list_options
    if [[ $choice == "b" || $choice == "B" ]]; then
        break
    fi
done
