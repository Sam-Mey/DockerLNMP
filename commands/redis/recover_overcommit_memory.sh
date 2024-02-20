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

if [ "$current_status" -eq 1 ]; then
    echo -e "${BOLD}${YELLOW}——————————————————————————————————————————————————温馨提示————————————————————————————————————————————————————————————${RESET}"
    echo -e "${BOLD}${RED} 当前 vm.overcommit_memory 的状态是: $current_status 表示启用了内存过度承诺 (Overcommit) 模式; ${RESET}"
    echo -e "${BOLD}${RED} 在这种模式下，内核允许分配超过系统实际可用物理内存的内存空间; ${RESET}"
    echo -e "${BOLD}${RED} 这意味着即使系统没有足够的物理内存，也可以继续分配更多的内存; 推荐 保持开启 内存超额. ${RESET}"
    echo -e "${BOLD}${YELLOW}——————————————————————————————————————————————————温馨提示————————————————————————————————————————————————————————————${RESET}\n"
    
    read -p "${BOLD}${GREEN} 是否关闭系统内存超额提交？ (n/y) [默认为 n]: ${RESET}" user_response
    user_response=${user_response:-n}
    if [ "$user_response" == "y" ]; then
        # 设置 vm.overcommit_memory 为 0
        sysctl vm.overcommit_memory=0
        
        # 如果用户选择不同意或者没有输入内容，退出脚本
        if [ "$user_response" != "y" ]; then
            echo "${BOLD}${RED} 您选择 关闭 系统内存超额提交,[注意：关闭系统内存超额提交后 (即恢复到默认状态)；这可能导致在内存不足时仍然分配内存，可能导致系统性能问题 以及 Redis 服务的运行警告！！！]. ${RESET}"
            exit 0
        fi
        
        # 使更改生效
        sysctl -p
        
        # 调用重启 Redis 的脚本
        "$RESTART_REDIS_SCRIPT_PATH"
    else
        echo -e "${BOLD}${YELLOW} 您选择保持开启系统内存超额提交. ${RESET}"
    fi
else
    echo -e "${BOLD}${RED} 当前 vm.overcommit_memory 的状态已经是 $current_status 无需修改. ${RESET}"
fi
