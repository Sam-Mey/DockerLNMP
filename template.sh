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

# Define menu options
options=(
    "${BOLD}${BLUE}  ${RESET}\n"
    
    "${BOLD}${RED}  ${RESET}"
    "${BOLD}${GREEN}  ${RESET}"
    "${BOLD}${GRAY}  ${RESET}"
)

# Show menu
function show_menu() {
    echo -e "${BOLD}${BLUE}—————————————————————————————————  ———————————————————————————————————${RESET}\n"
    for i in "${!options[@]}"; do
        if [[ $i -eq $(( ${#options[@]} - 1 )) ]]; then
            echo -e "${BOLD}${RED}m. ${options[$i]}${RESET}"  # q 返回选项
        else
            echo -e "${BOLD}${BLUE}$((i+1)). ${options[$i]}${RESET}"
        fi
    done
}

# Handle user choice
function menu_options() {
    read -p "${BOLD}${BLUE} 请输入选项编号:${RESET}" choice
    echo "DEBUG: User input is $choice"  # 添加调试信息
    case $choice in
        1)
            clear
            echo -e "${BOLD}${YELLOW} Docker LNMP 选项 ${RESET}"
            "$XXXXXXX"
        ;;
        2)
            clear
            echo -e "${BOLD}${YELLOW} WebSite ${RESET}"
            "$XXXXXX"
        ;;
        Q|q)
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
    show_menu
    menu_options
done
