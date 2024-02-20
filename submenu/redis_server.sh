#!/bin/bash

clear

# 进入脚本所在目录
cd "$(dirname "$0")"

# Include configuration
. /DockerLNMP/config.sh

# 定义颜色和样式，使用 tput
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

# Define redis_server options
options=(
    "${BOLD}${BLUE} 查看 Redis 配置文件 ${RESET}"
    "${BOLD}${GREEN} 启用系统内存超额提交 ${RESET}"
    "${BOLD}${RED} 关闭系统内存超额提交 (默认:vm.overcommit_memory = 0) ${RESET}\n"
    
    "${BOLD}${GRAY} 返回上一级 ${RESET}\n"
)

# Show redis_server
function show_redis_server() {
    echo -e "${BOLD}${BLUE}———————————————————————————————— Redis 服务 ———————————————————————————————— ${RESET}\n"
    for i in "${!options[@]}"; do
        if [[ $i -eq $(( ${#options[@]} - 1 )) ]]; then
            echo -e "${BOLD}${RED}b. ${options[$i]}${RESET}"  # b back
        else
            echo -e "${BOLD}${BLUE}$((i+1)). ${options[$i]}${RESET}"
        fi
    done
}

# Handle user choice
function redis_server_options() {
    read -p "${BOLD}${BLUE} 请输入选项编号:${RESET}" choice
    echo "DEBUG: User input is $choice"
    case $choice in
        1)
            clear
            echo -e "${BOLD}${YELLOW} 查看 Redis 配置文件 ${RESET}"
            "$XXXXXXX"
        ;;
        2)
            clear
            echo -e "${BOLD}${YELLOW} [Redis 必须] 启用系统内存超额提交... ${RESET}"
            "$SET_OVERCOMMIT_MEMORY_SCRIPT_PATH"
        ;;
        2)
            clear
            echo -e "${BOLD}${YELLOW} 正在关闭系统内存超额提交... ${RESET}"
            "$RECOVER_OVERCOMMIT_MEMORY_SCRIPT_PATH"
        ;;
        Q|q)
            clear
            echo "${BOLD}${RED} 谢谢使用，再见！ ${RESET}"
            exit 0
        ;;
        *)
            clear
            echo -e "${BOLD}${RED} 无效选项，请重新选择 ${RESET}"
        ;;
    esac
}

while true; do
    show_redis_server
    redis_server_options
done
