#!/bin/bash

# Include configuration
. /DockerLNMP/config.sh

RED=$(tput setaf 1)  
GREEN=$(tput setaf 2) 
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

echo "${RED}此脚本将删除所有匹配 DockerLNMP 目录与 dlnmp 或文件。请谨慎使用。${RESET}"

# 查找匹配的目录或文件
matches=$(sudo find / -type d -name "DockerLNMP" -o -type d -name "dlnmp" -o -type f -name "DockerLNMP" -o -type f -name "dlnmp")

if [ -n "$matches" ]; then
    echo echo -e "${BOLD}${YELLOW} 找到以下匹配项：${RESET}"
    echo echo -e "${RED}$matches${RESET}"

    read -p "${BOLD}${YELLOW} 是否执行删除？ (y/n): ${RESET}" choice

    if [ "$choice" == "y" ]; then
        # 执行删除命令
        sudo rm -rf $matches
        echo -e "${BOLD}${GREEN} 删除完成。${RESET}"
    else
        echo -e "${BOLD}${RED} 取消删除。${RESET}"
    fi
else
    echo -e "${BOLD}${YELLOW} 未找到有关 DockerLNMP 与 dlnmp 文件。${RESET}"
fi

