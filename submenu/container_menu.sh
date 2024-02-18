#!/bin/bash

clear

# 进入脚本所在目录
cd "$(dirname "$0")"

# 保存脚本所在目录的路径
SCRIPT_DIR="/docker_lnmp/lnmp" # 换为实际名称

# 引入配置
. "/docker_lnmp/config.sh"

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
    "${BOLD}${PURPLE} 进入容器 Nginx ${RESET}"
    "${BOLD}${PURPLE} 进入容器 MariaDB ${RESET}"
    "${BOLD}${PURPLE} 进入容器 PHP ${RESET}"
    "${BOLD}${PURPLE} 进入容器 Redis ${RESET}"
    "${BOLD}${PURPLE} 进入容器 phpMyAdmin ${RESET}\n"
    
    "${BOLD}${PURPLE} 查看容器 Nginx 的配置文件  ${RESET}"
    "${BOLD}${PURPLE} 查看容器 PHP 禁用的函数 ${RESET}"
    "${BOLD}${PURPLE} 查看容器 PHP 已安装扩展 ${RESET}"
    "${BOLD}${PURPLE} 查看容器 PHP 已启用扩展 ${RESET}\n"
    
    
    "${BOLD}${RED} 上一级菜单 [docker_lnmp] ${RESET}"
    "${BOLD}${GREEN} 安装 PHP 模组 [docker_lnmp] ${RESET}"
    "${BOLD}${GREEN} 启用 OPcache 与 JIT 扩展 [docker_lnmp] ${RESET}"
    
)

# Show 替换为实际名称
function show_goin_container_menu() {
    echo -e "${BOLD}${PURPLE}======== 容器菜单 ========${RESET}\n" # 换为实际名称
    for i in "${!options[@]}"; do
        if [[ $i -eq $(( ${#options[@]} - 3 )) ]]; then
            echo -e "${BOLD}${RED}q. ${options[$i]}${RESET}"  # q 退出选项
            elif [[ $i -eq $(( ${#options[@]} -2 )) ]]; then
            echo -e "${BOLD}${GREEN}i. ${options[$i]}${RESET}"  # u 安装 PHP 模组
            elif [[ $i -eq $(( ${#options[@]} -1 )) ]]; then
            echo -e "${BOLD}${GREEN}e. ${options[$i]}${RESET}\n"  # r 启用 OPcache 与 JIT 扩展
        else
            echo -e "${BOLD}${BLUE}$((i+1)). ${options[$i]}${RESET}"
        fi
    done
}

# Handle user choice
function handle_choice() {
    read -p "${BOLD}${BLUE} 请输入选项编号: ${RESET}" choice
    case $choice in
        1)
            clear
            echo -e "${BOLD}${YELLOW} 您正处于 Nginx 容器内部 ${RESET}"
            docker exec -it server-nginx-1 /bin/bash
        ;;
        2)
            clear
            echo -e "${BOLD}${YELLOW} 您正处于 MariaDB 容器内部 ${RESET}"
            docker exec -it server-mariadb-1 /bin/bash
        ;;
        3)
            clear
            echo -e "${BOLD}${YELLOW} 您正处于 PHP 容器内部 ${RESET}"
            docker exec -it server-php-1 /bin/bash
        ;;
        4)
            clear
            echo -e "${BOLD}${YELLOW} 您正处于 Redis 容器内部 ${RESET}"
            docker exec -it server-redis-1 /bin/bash
        ;;
        5)
            clear
            echo -e "${BOLD}${YELLOW} 您正处于 phpMyAdmin 容器内部 ${RESET}"
            docker exec -it server-phpmyadmin-1 /bin/bash
        ;;
        6)
            clear
            echo -e "${BOLD}${YELLOW} Nginx 配置文件 ${RESET}"
            "$CHECK_NGINX_CONF_SCRIPT_PATH"
        ;;
        7)
            clear
            echo -e "${BOLD}${YELLOW} PHP 禁用的函数 (您需要找到: 'disable_functions =' 查看详情) ${RESET}"
            "$CHECK_PHP_DISABLE_FUNCTIONS_SCRIPT_PATH"
        ;;
        8)
            clear
            echo -e "${BOLD}${YELLOW} 以下是 PHP 已安装的扩展 ${RESET}"
            "$CHECK_PHP_INSTALLED_MODULES_SCRIPT_PATH"
        ;;
        9)
            clear
            echo -e "${BOLD}${YELLOW} PHP 已启用了以下扩展 ${RESET}"
            "$CHECK_PHP_ENTERED_MODULES_SCRIPT_PATH"
        ;;
        M|m)
            clear
            echo "${BOLD}${RED} [docker_lnmp] 菜单 ${RESET}"
        ;;
        I|i)
            clear
            echo -e "${BOLD}${RED} 正在安装 PHP 指定模组... 如您需要自定义安装,请修改 'install_php_modules.sh' 脚本. ${RESET}"
            "$INSTALL_PHP_MODULES_SCRIPT_PATH"
        ;;
        E|e)
            clear
            echo -e "${BOLD}${YELLOW} 正在启用 OPcache 与 JIT... 您可根据序号查看 PHP 已启用的扩展 ${RESET}"
        ;;
        *)
            clear
            echo -e "${BOLD}${RED} 无效选项，请重新选择 ${RESET}"
        ;;
    esac
}

# 主循环
while true; do
    show_goin_container_menu # 换为实际名称
    handle_choice
    if [[ $choice == "m" || $choice == "M" ]]; then
        break  # 退出循环，返回到调用的主菜单
    fi
done


