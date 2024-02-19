#!/bin/bash

clear

# # 进入脚本所在目录
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
    "${BOLD}${PURPLE} 安装 Docker LNMP 环境 ${RESET}\n"
    
    "${BOLD}${PURPLE} 启动状态 ${RESET}"
    "${BOLD}${PURPLE} 运行日志 ${RESET}"
    "${BOLD}${PURPLE} 镜像网络 ${RESET}\n"
    
    "${BOLD}${PURPLE} 服务 >> ${RESET}\n"
    
    "${BOLD}${PURPLE} 重启 LNMP 服务 ${RESET}\n"
    "${BOLD}${PURPLE} 停止 LNMP 服务 ${RESET}\n"
    
    "${BOLD}${RED} 返回主菜单 ${RESET}"
    "${BOLD}${GRAY} 卸载 Docker LNMP 环境 ${RESET}\n"
)

function show_lnmp_menu() {
    echo -e "${BOLD}${BLUE}============ Docker LNMP 首页 ============${RESET}\n"
    for i in "${!options[@]}"; do
        if [[ $i -eq $(( ${#options[@]} - 2 )) ]]; then
            echo -e "${BOLD}${RED}b. ${options[$i]}${RESET}"  # b 返回
            elif [[ $i -eq $(( ${#options[@]} -1 )) ]]; then
            echo -e "${BOLD}${GRAY}d. ${options[$i]}${RESET}"  # d 卸载
        else
            echo -e "${BOLD}${PURPLE}$((i+1)). ${options[$i]}${RESET}"
        fi
    done
}

# Handle user choice
function lnmp_options() {
    read -p "${BOLD}${BLUE} 请输入选项编号: ${RESET}" choice
    echo "DEBUG: User input is $choice"  # debug
    case $choice in
        1)
            clear
            echo -e "${BOLD}${YELLOW} 安装 LNMP 环境... ${RESET}"
            "$INSTALL_LNMP_SCRIPT_PATH"
        ;;
        2)
            clear
            echo -e "${BOLD}${YELLOW} 当前所有容器启动状态： ${RESET}"
            docker ps -a
        ;;
        3)
            clear
            echo -e "${BOLD}${YELLOW} 当前所有容器运行日志： ${RESET}"
            cd /DockerLNMP/lnmp/build && docker-compose logs
        ;;
        4)
            clear
            echo -e "${BOLD}${YELLOW} 系统镜像/网络列表 ${RESET}"
            docker images
            docker network ls
        ;;
        5)
            clear
            echo -e "${BOLD}${YELLOW} 服务列表: ${RESET}"
            "$SERVICE_MENU_SCRIPT_PATH"
        ;;
        6)
            clear
            echo -e "${BOLD}${YELLOW} 正在重启所有容器... ${RESET}"
            "$RESTART_SERVER_SCRIPT_PATH"
        ;;
        7)
            clear
            echo -e "${BOLD}${YELLOW} 正在停止所有容器... ${RESET}"
            docker stop $(docker ps -aq)
        ;;
        B|b)
            clear
            echo "${BOLD}${RED} 主菜单！ ${RESET}"
        ;;
        D|d)
            clear
            read -p "$(echo -e "${BOLD}${YELLOW}此操作仅卸载所有创建的容器、镜像、网络，并不是卸载 Docker! 是否确认卸载整个 LNMP 环境? (默认为N) | [N/y]: ${RESET}")" -i "N" answer
            if [ "${answer,,}" = "y" ]; then
                echo -e "${BOLD}${RED} 正在卸载 LNMP 环境... ${RESET}"
                "$UNINSTALL_LNMP_SCRIPT_PATH"
                exit 0
            else
                echo -e "${BOLD}${YELLOW} 已取消卸载 ${RESET}"
            fi
        ;;
        *)
            clear
            echo -e "${BOLD}${RED} 无效选项，请重新选择 ${RESET}"
        ;;
    esac
}

while true; do
    show_lnmp_menu
    lnmp_options
    if [[ $choice == "b" || $choice == "B" ]]; then
        break
    fi
done
