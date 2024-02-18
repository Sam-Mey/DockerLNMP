#!/bin/bash

clear

# 进入脚本所在目录
cd "$(dirname "$0")"

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
    
    "${BOLD}${PURPLE} 重启 ${RESET}\n"
    
    "${BOLD}${RED} 主菜单 ${RESET}"
    "${BOLD}${GRAY} 卸载 Docker LNMP 环境 ${RESET}\n"
)

function show_lnmp_menu() {
    echo -e "${BOLD}${BLUE}============ Docker LNMP 选项 ============${RESET}\n"
    for i in "${!options[@]}"; do
        if [[ $i -eq $(( ${#options[@]} - 2 )) ]]; then
            echo -e "${BOLD}${RED}m. ${options[$i]}${RESET}"  # m 返回选项
            elif [[ $i -eq $(( ${#options[@]} -1 )) ]]; then
            echo -e "${BOLD}${GRAY}r. ${options[$i]}${RESET}"  # r 卸载选项
        else
            echo -e "${BOLD}${PURPLE}$((i+1)). ${options[$i]}${RESET}"
        fi
    done
}

# Handle user choice
function lnmp_options() {
    read -p "${BOLD}${BLUE} 请输入选项编号: ${RESET}" choice
    case $choice in
        1)
            if command -v docker &> /dev/null; then
                clear
                echo -e "${BOLD}${YELLOW} Docker 已安装，正在创建 LNMP 环境... ${RESET}"
                "$INSTALL_LNMP_SCRIPT_PATH"
            else
                echo -e "${RED}未安装 Docker !!! 即将为您安装 Docker...${RESET}"
                "$DOCKER_SCRIPT_PATH"
                
                if command -v docker &> /dev/null; then
                    echo -e "${BOLD}${YELLOW} Docker 安装成功，将创建 LNMP 环境... ${RESET}"
                    "$INSTALL_LNMP_SCRIPT_PATH"
                else
                    echo -e "${RED}Docker 安装失败，请检查安装过程中的错误。无法继续执行 LNMP 脚本！！！${RESET}"
                fi
            fi
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
            echo -e "${BOLD}${YELLOW} 系统镜像/网络列表： ${RESET}"
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
        M|m)
            clear
            echo "${BOLD}${RED} 主菜单！ ${RESET}"
        ;;
        R|r)
            clear
            read -p "$(echo -e "${BOLD}${YELLOW}此操作仅卸载所有创建的容器、镜像、网络，并不是卸载 Docker! 是否确认卸载整个 LNMP 环境? (默认为N) | [N/y]: ${RESET}")" -i "N" answer
            if [ "${answer,,}" = "y" ]; then
                echo -e "${BOLD}${RED} 正在卸载 LNMP 环境... ${RESET}"
                "$UNINSTALL_LNMP_SCRIPT_PATH"
                exit 0
            else
                echo -e "${BOLD}${YELLOW} 已取消卸载. ${RESET}"
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
    if [[ $choice == "m" || $choice == "M" ]]; then
        break
    fi
done


