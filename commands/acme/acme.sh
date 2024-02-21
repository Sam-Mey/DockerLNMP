#!/bin/bash

# Requires root permissions
root_need() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "\033[31m 错误:该脚本必须以 root 身份运行! \033[0m" 1>&2
        exit 1
    fi
}

# Call functions
root_need

clear

# Go to the directory where the script is located
cd "$(dirname "$0")"

# Include configuration
. /DockerLNMP/config.sh

# Define colors and styles using tput
BOLD=$(tput bold)         # 粗体
DIM=$(tput dim)           # 细体
GRAY=$(tput setaf 0)      # 灰色
RED=$(tput setaf 1)       # 红色
GREEN=$(tput setaf 2)     # 绿色
YELLOW=$(tput setaf 3)    # 黄色
BLUE=$(tput setaf 4)      # 蓝色
PURPLE=$(tput setaf 5)    # 紫色
CYAN=$(tput setaf 6)      # 青色
WHITE=$(tput setaf 7)     # 白色

UNDERLINE=$(tput smul): # 下划线
BLINK=$(tput blink):    # 闪烁
REVERSE=$(tput rev):    # 反显

RESET=$(tput sgr0)        # 重置样式

# Define menu options
options=(
    "${BOLD}${PURPLE} Ubuntu/Debian ${RESET}\n"
    "${BOLD}${PURPLE} CentOS ${RESET}"
    
    "${BOLD}${WHITE} 返回上一级 [Website] ${RESET}\n"
)

# Show menu
function show_menu() {
    echo -e "${BOLD}${PURPLE}———————————————————————————————— 证书申请 —————————————————————————————————— ${RESET}\n"
    for i in "${!options[@]}"; do
        if [[ $i -eq $(( ${#options[@]} - 1 )) ]]; then
            echo -e "${BOLD}${WHITE}b. ${options[$i]}${RESET}"  # b back
        else
            echo -e "${BOLD}${PURPLE}$((i+1)). ${options[$i]}${RESET}"
        fi
    done
}

# Handle user choice
function menu_options() {
    read -p "${BOLD}${PURPLE} 请输入选项编号:${RESET}" choice
    echo "DEBUG: User input is $choice"
    case $choice in
        1)
            clear
            echo -e "${BOLD}${YELLOW} [Ubuntu/Debian 系统] 将为您申请 SSL 证书... ${RESET}"
            "$ACME_UBUNTU_DEBIAN_SCRIPT_PATH"
        ;;
        2)
            clear
            echo -e "${BOLD}${YELLOW} [CentOS 系统] 将为您申请 SSL 证书... ${RESET}"
            "$ACME_CENTOS_SCRIPT_PATH"
        ;;
        B|b)
            clear
            echo "${BOLD}${WHITE} [Website] 菜单 ${RESET}"
            exit 0
        ;;
        *)
            clear
            echo -e "${BOLD}${RED} 无效选项，请重新选择 ${RESET}"
        ;;
    esac
}

while true; do
    show_menu
    menu_options
    if [[ $choice == "b" || $choice == "B" ]]; then
        break
    fi
done
