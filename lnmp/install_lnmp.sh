#!/bin/bash

# Include configuration
. /DockerLNMP/config.sh

BOLD=$(tput bold)
RED=$(tput setaf 1)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)

# 检查系统是否安装 Docker
if ! command -v docker || ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}未安装 Docker 现在为您安装...${RESET}"
    # 执行 Docker 安装脚本
else
    echo -e "${CYAN}您已安装的 Docker 版本：$(docker --version)${RESET}"
    echo -e "${CYAN}您已安装的 Docker Compose 版本：$(docker-compose --version)${RESET}"
    echo -e "${RED} 您已安装了docker 与 compose 正在为您创建 LNMP 环境 ${RESET}"
    # 执行 LNMP 安装脚本
    "$GET_LNMP_SCRIPT_PATH"
fi
