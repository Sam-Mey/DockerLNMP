#!/bin/bash

clear

# Enter the directory where the script is located
cd "$(dirname "$0")"

# Include configuration
. /DockerLNMP/config.sh

# Define colors and styles, use tput
BOLD=$(tput bold)        # 粗体
GRAY=$(tput setaf 0)      # 灰色
RED=$(tput setaf 1)       # 红色
GREEN=$(tput setaf 2)     # 绿色
YELLOW=$(tput setaf 3)    # 黄色
BLUE=$(tput setaf 4)      # 蓝色
PURPLE=$(tput setaf 5)    # 紫色
CYAN=$(tput setaf 6)      # 青色
WHITE=$(tput setaf 7)     # 白色

RESET=$(tput sgr0)        # 重置样式

# Define website_menu options
options=(
    "${BOLD}${BLUE} 站点部署 ${RESET}"
    "${BOLD}${GREEN} SSL证书 ${RESET}\n"
    
    "${BOLD}${WHITE} 返回主菜单 ${RESET}\n"
)

# Show website_menu
function show_website_menu() {
    echo -e "${BOLD}${BLUE}———————————————————————————————— 站点部署 ———————————————————————————————— ${RESET}\n"
    for i in "${!options[@]}"; do
        if [[ $i -eq $(( ${#options[@]} - 1 )) ]]; then
            echo -e "${BOLD}${WHITE}b. ${options[$i]}${RESET}"  # b back
        else
            echo -e "${BOLD}${BLUE}$((i+1)). ${options[$i]}${RESET}"
        fi
    done
}

# Handle user choice
function website_menu_options() {
    read -p "${BOLD}${BLUE} 请输入选项编号: ${RESET}" choice
    echo "DEBUG: User input is $choice"
    case $choice in
        1)
            clear
            echo -e "${BOLD}${BLUE} 添加站点 ${RESET}"
            "$ADD_SITE_SCRIPT_PATH"
        ;;
        2)
            clear
            echo -e "${BOLD}${GREEN} 申请证书 ${RESET}"
            "$XXXXXX"
        ;;
        B|b)
            clear
            echo "${BOLD}${WHITE} 主菜单 ${RESET}"
            exit 0
        ;;
        *)
            clear
            echo -e "${BOLD}${RED} 无效选项，请重新选择 ${RESET}"
        ;;
    esac
}

while true; do
    show_website_menu
    website_menu_options
done
