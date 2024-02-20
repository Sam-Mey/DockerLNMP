#!/bin/bash

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

# 检查当前 vm.overcommit_memory 的状态
current_status=$(cat /proc/sys/vm/overcommit_memory)

if [ "$current_status" -eq 0 ]; then
    echo -e "${BOLD}${YELLOW} 当前 vm.overcommit_memory 的状态是: $current_status 表示不检查,允许任何内存分配.这可能导致 Rsdis 在内存不足时仍然分配内存,可能导致系统性能问题, 推荐 开启 内存超额 ${RESET}"
    
    read -p "${BOLD}${GREEN}是否启用系统内存超额提交？ (y/n) [默认为 y]: ${RESET}" user_response
    user_response=${user_response:-y}
    if [ "$user_response" == "y" ]; then
        # 设置 vm.overcommit_memory 为 1
        sysctl vm.overcommit_memory=1
        
        # 如果用户选择不同意或者没有输入内容，退出脚本
        if [ "$user_response" != "y" ]; then
            echo "${BOLD}${RED} 您选择 不启用 系统内存超额提交. ${RESET}"
            exit 0
        fi
        
        # 使更改生效
        sysctl -p
        
        # 调用重启 Redis 的脚本
        "$RESTART_REDIS_SCRIPT_PATH"
    else
        echo -e "${BOLD}${RED} 用户选择不启用系统内存超额提交，未做任何更改. ${RESET}"
    fi
else
    echo -e "${BOLD}${RED} 当前 vm.overcommit_memory 的状态已经不是 $current_status 无需修改. ${RESET}"
fi
