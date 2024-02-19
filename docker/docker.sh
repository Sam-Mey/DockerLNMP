#!/bin/bash

clear

# 进入脚本所在目�?
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

# Define docker options
options=(
    "${BOLD}${BLUE} Ubuntu/Debian ${RESET}"
    "${BOLD}${BLUE} CentOS ${RESET}"
    "${BOLD}${BLUE} Arm64 系统 ${RESET}"
    "${BOLD}${GRAY} DD 系统 ${RESET}\n"
    
    "${BOLD}${RED} 返回主菜�?${RESET}\n"
)

# Show docker
function show_docker() {
    echo -e "${BOLD}${BLUE} ———————————————————�?安装 Docker / Compose ———————————————————�?${RESET}\n"
    for i in "${!options[@]}"; do
        if [[ $i -eq $(( ${#options[@]} - 1 )) ]]; then
            echo -e "${BOLD}${RED}b. ${options[$i]}${RESET}"  # b 返回选项
        else
            echo -e "${BOLD}${BLUE}$((i+1)). ${options[$i]}${RESET}"
        fi
    done
}

# Handle user choice
function docker_options() {
    read -p "${BOLD}${BLUE} 请输入选项编号:${RESET}" choice
    echo "DEBUG: User input is $choice"
    case $choice in
        1)
            clear
            echo -e "${BOLD}${YELLOW} [Ubuntu/Debian] 正在安装 Docker... ${RESET}"
            "$UBUNTU_DEBIAN_SCRIPT_PATH"
        ;;
        2)
            clear
            echo -e "${BOLD}${YELLOW} [CentOS] 正在安装 Docker... ${RESET}"
            "$CENTOS_SCRIPT_PATH"
        ;;
        3)
            clear
            echo -e "${BOLD}${YELLOW} [Arm64] 正在安装 Docker... ${RESET}"
            "$UBUNTU_DEBIAN_ARM64_SCRIPT_PATH"
        ;;
        4)
            clear
            echo -e "${BOLD}${YELLOW} [DD System] 正在安装 Docker... ${RESET}"
            "$DDSYSTEM_SCRIPT_PATH"
        ;;
        B|b)
            clear
            echo "${BOLD}${RED} 主菜�?${RESET}"
        ;;
        *)
            clear
            echo -e "${BOLD}${RED} 无效选项，请重新选择 ${RESET}"
        ;;
    esac
}

while true; do
    show_docker
    docker_options
done
