#!/bin/bash

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

# 在根目录下递归查找名为 "DockerLNMP" 和 "dlnmp" 的文件夹
result_DockerLNMP=$(find / -type d -name "DockerLNMP" 2>/dev/null)
result_dlnmp=$(find / -type d -name "dlnmp" 2>/dev/null)

if [ -n "$result_DockerLNMP" ] || [ -n "$result_dlnmp" ]; then
    # Found 'DockerLNMP' or 'dlnmp' folder(s) at:
    echo "${BOLD}${RED} 发现 'DockerLNMP' 或 'dlnmp' 文件夹（目录）在： ${RESET}"
    
    [ -n "$result_DockerLNMP" ] && echo "${BOLD}${RED} $result_DockerLNMP ${RESET}"
    [ -n "$result_dlnmp" ] && echo "${BOLD}${RED} $result_dlnmp ${RESET}"
    
    # 确认用户是否要删除
    read -p "${BOLD}${YELLOW}是否要删除这些文件夹？ (Y/N): ${RESET}" confirmation
    if [ "$confirmation" == "Y" ] || [ "$confirmation" == "y" ]; then
        # 删除 'DockerLNMP' 和 'dlnmp' 文件夹
        [ -n "$result_DockerLNMP" ] && rm -rf "$result_DockerLNMP"
        [ -n "$result_dlnmp" ] && rm -rf "$result_dlnmp"
        
        # 删除 '/usr/local/bin/dlnmp' 链接
        rm -f /usr/local/bin/dlnmp
        
        echo "${BOLD}${RED} 删除了 'DockerLNMP' 主体 和 'dlnmp' 快捷方式. ${RESET}"
    else
        echo "${BOLD}${GREEN} 取消了删除操作. ${RESET}"
    fi
else
    echo "${BOLD}${RED} 在任何目录中找不到关于 'DockerLNMP' 或 'dlnmp' 文件夹. ${RESET}"
fi
