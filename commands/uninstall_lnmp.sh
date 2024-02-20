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

lnmp_allcontainer_id=$(docker ps -a -q)
lnmp_allimages_id=$(docker images -q)
lnmp_allnetwork_id=$(docker network ls -q)

lnmp_container() {
    local allcontainer_id=$lnmp_allcontainer_id
    local allimages_id=$lnmp_allimages_id
    local allnetwork_id=$lnmp_allnetwork_id
    
    read -p "$(echo -e "${BOLD}${YELLOW} 此操作仅卸载所有创建的容器、镜像、网络，并不是卸载 Docker! 是否确认卸载整个 LNMP 环境? (默认为N) | [N/y]: ${RESET}")" -i "N" answer
    
    if [ "${answer,,}" = "y" ]; then
        echo -e "${BOLD}${GRAY} 正在卸载 LNMP 环境... ${RESET}"
        
        if docker inspect "$allcontainer_id" > /dev/null 2>&1; then
            docker stop $allcontainer_id
            docker rm $allcontainer_id
        fi
        
        if docker inspect "$allimages_id" > /dev/null 2>&1; then
            docker rmi $allimages_id
        fi
        
        if docker inspect "$allnetwork_id" > /dev/null 2>&1; then
            echo "y" | docker network prune
        fi
        
        echo -e "${BOLD}${GREEN} LNMP 环境已成功卸载 ${RESET}"
        return 0  # Success
    else
        echo -e "${BOLD}${YELLOW} 已取消卸载 ${RESET}"
        return 1  # Failure
    fi
}

lnmp_container
