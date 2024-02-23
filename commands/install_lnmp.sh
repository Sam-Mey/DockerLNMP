#!/bin/bash

# 定义 countdown 函数
function countdown {
    local seconds=$1
    
    while [ $seconds -gt 0 ]; do
        echo -e "${WHITE}" "倒计时 $seconds 秒后 为您创建 [LNMP] 环境 ${RESET}"
        sleep 1
        ((seconds--))
    done
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

docker_version=$(docker --version)
compose_version=$(docker-compose --version)

# 检查系统是否安装 Docker
if [ -z "$docker_version" ] || [ -z "$compose_version" ]; then
    echo -e "${BOLD}${YELLOW} 未安装 Docker 现在为您安装... ${RESET}"
    # 执行 Docker 安装脚本
    "$DOCKER_SCRIPT_PATH"
else
    echo -e "${BOLD}${GREEN} 您已安装了 Docker 版本：$docker_version ${RESET}"
    echo -e "${BOLD}${GREEN} 您已安装了 Docker Compose 版本：$compose_version ${RESET}"
    
    countdown 10
    "$GET_LNMP_SCRIPT_PATH"
fi

## docker swarm init --advertise-addr 129.154.225.43