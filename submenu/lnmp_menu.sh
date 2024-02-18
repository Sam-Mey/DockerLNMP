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
    "${BOLD}${PURPLE} 安装 Docker LNMP 环境 ${RESET}\n"
    
    "${BOLD}${PURPLE} 启动状态 ${RESET}"
    "${BOLD}${PURPLE} 运行状态 ${RESET}"
    "${BOLD}${PURPLE} 镜像网络 ${RESET}\n"
    
    "${BOLD}${PURPLE} 服务 >> ${RESET}\n"
    
    "${BOLD}${PURPLE} 重启 ${RESET}\n"
    
    "${BOLD}${RED} 主菜单 ${RESET}"
    "${BOLD}${GRAY} 卸载 Docker LNMP 环境 ${RESET}\n"
)

# Show 替换为实际名称
function show_lnmp_menu() {
    echo -e "${BOLD}${BLUE}============ Docker LNMP 选项 ============${RESET}\n" # 换为实际名称
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
function handle_choice() {
    read -p "${BOLD}${BLUE} 请输入选项编号: ${RESET}" choice
    case $choice in
        1)
            # 检查是否安装了 Docker
            if command -v docker &> /dev/null; then
                clear
                echo -e "${BOLD}${YELLOW} Docker 已安装，正在创建 LNMP 环境... ${RESET}"
                "$INSTALL_LNMP_SCRIPT_PATH"
            else
                echo -e "${RED}未安装 Docker !!! 即将为您安装 Docker...${RESET}"
                "$DOCKER_SCRIPT_PATH"
                
                # 再次检查 Docker 是否安装成功
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
            echo -e "${BOLD}${YELLOW} 容器启动状态... ${RESET}"
            docker ps -a
        ;;
        3)
            clear
            echo -e "${BOLD}${YELLOW} 运行状态... ${RESET}"
            docker-compose up
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
            echo -e "${BOLD}${YELLOW} 正在加载所有容器... ${RESET}"
            "$RESTART_CONTAINER_SCRIPT_PATH"
        ;;
        M|m)
            clear
            echo "${BOLD}${RED} 主菜单！ ${RESET}"
        ;;
        R|r)
            clear
            # 提示消息，默认值为 N
            read -p "$(echo -e "${BOLD}${YELLOW}此操作仅卸载所有创建的容器、镜像、网络，并不是卸载 Docker! 是否确认卸载整个 LNMP 环境? (默认为N) | [N/y]: ${RESET}")" -i "N" answer
            # 根据用户的选择执行相应操作
            if [ "${answer,,}" = "y" ]; then
                echo -e "${BOLD}${RED} 正在卸载 LNMP 环境... ${RESET}"
                # 执行卸载 整个 LNMP 环境 的操作，可以调用相应的脚本或命令
                "$UNINSTALL_LNMP_SCRIPT_PATH"
                exit 0  # 执行完成退出脚本
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

# 主循环
while true; do
    show_lnmp_menu # 换为实际名称
    handle_choice
    if [[ $choice == "m" || $choice == "M" ]]; then
        break  # 退出循环，返回到调用的主菜单
    fi
done


