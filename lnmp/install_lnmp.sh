#!/bin/bash

# 定义 countdown 函数
function countdown {
    local seconds=$1
    
    while [ $seconds -gt 0 ]; do
        echo_color "green" "倒计时: $seconds 秒后"
        sleep 1
        ((seconds--))
    done
    # ... 其余倒计时的逻辑
}

# 进入脚本所在目录
cd "$(dirname "$0")"

# Include configuration
. /DockerLNMP/config.sh

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
BOLD=$(tput bold)
RED=$(tput setaf 1)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)

# 检查系统是否安装 Docker
if ! command -v docker || ! command -v docker-compose &> /dev/null; then
    echo -e "${BOLD}${RED} 未安装 Docker 现在为您安装... ${RESET}"
    # 执行 Docker 安装脚本
    "$DOCKER_SCRIPT_PATH"
else
    echo -e "${BOLD}${CYAN} 您已安装的 Docker 版本：$(docker --version) ${RESET}"
    echo -e "${BOLD}${CYAN} 您已安装的 Docker Compose 版本：$(docker-compose --version) ${RESET}"
    echo -e "${BOLD}${RED} 您已安装了docker 与 compose 正在为您创建 LNMP 环境  ${RESET}"
    
    countdown 10
    # 执行 LNMP 安装脚本
    "$GET_LNMP_SCRIPT_PATH"
fi
