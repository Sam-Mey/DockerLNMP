#!/bin/bash

# Include configuration
. /DockerLNMP/config.sh

# Define colors and styles using tput
BOLD=$(tput bold)         # 粗体
DIM=$(tput dim)           # 细体
GRAY=$(tput setaf 0)      # 灰色
RED=$(tput setaf 1)       # 红色
GREEN=$(tput setaf 2)     # 绿色
YELLOW=$(tput setaf 3)    # 黄色
BLUE=$(tput setaf 4)      # 蓝色
PURPLE=$(tput setaf 5)    # 紫色
CYAN=$(tput setaf 6)      # 青色
WHITE=$(tput setaf 7)     # 白色

UNDERLINE=$(tput smul): # 设置为下划线
BLINK=$(tput blink):    # 设置为闪烁
REVERSE=$(tput rev):    # 设置为反显

RESET=$(tput sgr0)        # 重置样式

# Get the IDs of all Docker containers, including stopped containers
lnmp_allcontainer_ids=$(docker ps -a -q)
lnmp_allimages_ids=$(docker images -q)
lnmp_allnetwork_ids=$(docker network ls --format="{{.ID}} {{.Name}}" | grep -v 'bridge\|host\|none' | awk '{print $1}')

read -p "$(echo -e "${BOLD}${RED} 此操作仅卸载所有创建的容器、镜像、网络，并不是卸载 Docker! 是否确认卸载整个 LNMP 环境? (默认为N) | [N/y]: ${RESET}")" -i "N" answer
if [ "${answer,,}" = "y" ]; then
    # check containers
    if [ -n "$lnmp_allcontainer_ids" ]; then
        echo -e "${BOLD}${YELLOW} 系统中的所有Docker容器： ${RESET}"
        echo -e "${RED} $lnmp_allcontainer_ids ${RESET}"
        
        echo -e "${BOLD}${YELLOW} 开始执行卸载操作... ${RESET}"
        
        for container_id in $lnmp_allcontainer_ids; do
            echo -e "${YELLOW} 正在停止容器: ${RED} $container_id  ${RESET}"
            docker stop $container_id
            echo -e "${YELLOW} 正在卸载容器: ${RED} $container_id  ${RESET}"
            docker rm $container_id
        done
        
        echo -e "${BOLD}${GREEN} 卸载操作完成 ${RESET}"
        
    else
        echo -e "${BOLD}${YELLOW} 系统没有任何容器 ${RESET}"
    fi
    
    # check images
    if [ -n "$lnmp_allimages_ids" ]; then
        echo -e "${BOLD}${YELLOW} 系统中的所有Docker镜像： ${RESET}"
        echo -e "${RED} $lnmp_allimages_ids"
        
        echo -e "${BOLD}${YELLOW} 开始执行卸载操作... ${RESET}"
        
        for image_id in $lnmp_allimages_ids; do
            echo -e "${YELLOW} 正在删除镜像: ${RED} $image_id ${RESET}"
            docker rmi $image_id
        done
        
        echo -e "${BOLD}${GREEN} 卸载操作完成 ${RESET}"
        
    else
        echo -e "${BOLD}${YELLOW} 系统没有任何镜像 ${RESET}"
    fi
    
    # check networks
    if [ -n "$lnmp_allnetwork_ids" ]; then
        echo -e "${BOLD}${YELLOW} 系统中的所有Docker网络： ${RESET}"
        echo -e "${RED} $lnmp_allnetwork_ids ${RESET}"
        
        echo -e "${BOLD}${RED} 开始执行卸载操作... ${RESET}"
        
        for network_id in $lnmp_allnetwork_ids; do
            echo -e "${YELLOW} 正在删除网络: ${RED} $network_id ${RESET}"
            docker network rm $network_id
        done
        
        echo -e "${BOLD}${GREEN} 卸载操作完成 ${RESET}"
        
    else
        echo -e "${BOLD}${YELLOW} 系统没有任何网络 ${RESET}"
    fi
else
    echo -e "${BOLD}${RED} 您已取消操作 ${RESET}"
fi
