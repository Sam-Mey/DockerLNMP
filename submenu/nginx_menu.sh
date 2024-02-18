#!/bin/bash

clear

# 进入脚本所在目录
cd "$(dirname "$0")"

# 引入配置
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
    "${BOLD}${RED} 查看日志 ${RESET}"
    "${BOLD}${GREEN} 运行状态 ${RESET}"
    "${BOLD}${GRAY} 重新加载 ${RESET}\n"
    
    "${BOLD}${GRAY} 返回上一级 ${RESET}\n"
)

# Show nginx
function nginx_nginx() {
    echo -e "${BOLD}${BLUE}————————————————————————————————— Nginx 容器服务 ———————————————————————————————————${RESET}\n"
    for i in "${!options[@]}"; do
        if [[ $i -eq $(( ${#options[@]} - 1 )) ]]; then
            echo -e "${BOLD}${RED}m. ${options[$i]}${RESET}"  # m 返回选项
        else
            echo -e "${BOLD}${BLUE}$((i+1)). ${options[$i]}${RESET}"
        fi
    done
}

# Handle user choice
function nginx_options() {
    read -p "${BOLD}${BLUE} 请输入选项编号:${RESET}" choice
    echo "DEBUG: User input is $choice"  # 添加调试信息
    case $choice in
        1)
            clear
            echo -e "${BOLD}${YELLOW} XXX ${RESET}"
            "$XXXXXXX"
        ;;
        2)
            clear
            echo -e "${BOLD}${YELLOW} XXX ${RESET}"
            "$XXXXXX"
        ;;
        3)
            clear
            echo -e "${BOLD}${YELLOW} XXX ${RESET}"
            "$XXXXXX"
        ;;
        4)
            clear
            echo -e "${BOLD}${YELLOW} XXX ${RESET}"
            "$XXXXXX"
        ;;
        M|m)
            clear
            echo "${BOLD}${RED} 谢谢使用，再见！ ${RESET}"
            exit 0  # 退出脚本
        ;;
        *)
            clear
            echo -e "${BOLD}${RED} 无效选项，请重新选择 ${RESET}"
        ;;
    esac
}

# 主循环
while true; do
    show_nginx
    nginx_options
done
