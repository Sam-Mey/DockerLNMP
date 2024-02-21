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

read -p "$(echo -e "${BOLD}${YELLOW}是否确认卸载脚本? (默认为N) | [N/y]: ${RESET}")" -i "N" answer
if [ "${answer,,}" = "y" ]; then
    echo -e "${BOLD}${RED} 正在卸载脚本... ${RESET}"
    # Recursively look for a folder named "DockerLNMP" or "dlnmp" in the root directory
    result_DockerLNMP=$(find / -type d -name "DockerLNMP" 2>/dev/null)
    result_dlnmp=$(find / -type d -name "dlnmp" 2>/dev/null)
    
    if [ -n "$result_DockerLNMP" ] || [ -n "$result_dlnmp" ]; then
        # Found 'DockerLNMP' or 'dlnmp' folder(s) at:
        echo "${BOLD}${RED} 发现 'DockerLNMP' 或 'dlnmp' 文件夹（目录）在：${RESET}"
        
        [ -n "$result_DockerLNMP" ] && echo "${BOLD}${RED} $result_DockerLNMP ${RESET}"
        [ -n "$result_dlnmp" ] && echo "${BOLD}${RED} $result_dlnmp ${RESET}"
        
        # confirm deletion ?
        read -p "${BOLD}${YELLOW}是否要删除这些文件夹？ (Y/N): ${RESET}" confirmation
        if [ "$confirmation" == "Y" ] || [ "$confirmation" == "y" ]; then
            # Delete 'DockerLNMP' and 'dlnmp' folders?
            [ -n "$result_DockerLNMP" ] && rm -rf "$result_DockerLNMP"
            [ -n "$result_dlnmp" ] && rm -rf "$result_dlnmp"
            
            # Remove '/usr/local/bin/dlnmp' link
            rm -f /usr/local/bin/dlnmp
            
            echo "${BOLD}${RED} 删除了 'DockerLNMP' 主体 和 'dlnmp' 快捷方式. ${RESET}"
        else
            echo "${BOLD}${GREEN} 取消了删除操作 ${RESET}"
        fi
    else
        echo "${BOLD}${RED} 在任何目录中找不到关于 'DockerLNMP' 或 'dlnmp' 文件夹 ${RESET}"
    fi
    
    exit 0
else
    echo -e "${BOLD}${YELLOW} 脚本卸载已取 ${RESET}"
fi