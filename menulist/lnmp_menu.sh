#!/bin/bash

clear

# Include configuration
. "/DockerLNMP/config.sh"

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

UNDERLINE=$(tput smul): # 设置为下划线
BLINK=$(tput blink):    # 设置为闪烁
REVERSE=$(tput rev):    # 设置为反显

RESET=$(tput sgr0)        # 重置样式

# Define menu options
options=(
    "${BOLD}${CYAN} 安装 Docker LNMP 环境 ${RESET}\n"
    
    "${BOLD}${CYAN} 启动状态 ${RESET}"
    "${BOLD}${CYAN} 运行日志 ${RESET}"
    "${BOLD}${CYAN} 镜像网络 ${RESET}"
    "${BOLD}${CYAN} 容器服务 >> ${RESET}\n"
    
    "${BOLD}${YELLOW} 重启 LNMP 服务 ${RESET}"
    "${BOLD}${RED} 停止 LNMP 服务 ${RESET}\n"
    
    "${BOLD}${WHITE} 返回主菜单 ${RESET}"
    "${BOLD}${GRAY} 卸载 Docker LNMP 环境 ${RESET}\n"
)

function show_lnmp_menu() {
    echo -e "${BOLD}${CYAN}============ Docker LNMP ============${RESET}\n"
    for i in "${!options[@]}"; do
        if [[ $i -eq $(( ${#options[@]} - 4 )) ]]; then
            echo -e "${BOLD}${YELLOW}r. ${options[$i]}${RESET}"  # r restart
            elif [[ $i -eq $(( ${#options[@]} -3 )) ]]; then
            echo -e "${BOLD}${RED}s. ${options[$i]}${RESET}"  # s stop
            elif [[ $i -eq $(( ${#options[@]} -2 )) ]]; then
            echo -e "${BOLD}${WHITE}b. ${options[$i]}${RESET}"   # b back
            elif [[ $i -eq $(( ${#options[@]} -1 )) ]]; then
            echo -e "${BOLD}${GRAY}d. ${options[$i]}${RESET}"   # d del
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
            echo -e "${BOLD}${YELLOW} 容器服务列表: ${RESET}"
            "$CONTAINERS_SERVER_LIST_SCRIPT_PATH"
        ;;
        R|r)
            clear
            echo -e "${BOLD}${WHITE} 正在重启所有容器... ${RESET}"
            "$RESTART_ALLCONTIANERS_SERVER_SCRIPT_PATH"
        ;;
        S|s)
            clear
            echo -e "${BOLD}${RED} 正在停止所有容器... ${RESET}"
            docker stop $(docker ps -aq)
        ;;
        B|b)
            clear
            echo "${BOLD}${WHITE} 主菜单！ ${RESET}"
        ;;
        D|d)
            clear
            "$UNINSTALL_LNMP_SCRIPT_PATH"
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
