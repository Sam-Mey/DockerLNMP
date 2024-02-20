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

# 获取所有Docker容器的ID，包括停止状态的容器
lnmp_allcontainer_ids=$(docker ps -a -q)
lnmp_allimages_ids=$(docker images -q)
lnmp_allnetwork_ids=$(docker network ls --format="{{.ID}} {{.Name}}" | grep -v 'bridge\|host\|none' | awk '{print $1}')

read -p "$(echo -e "${BOLD}${YELLOW} 此操作仅卸载所有创建的容器、镜像、网络，并不是卸载 Docker! 是否确认卸载整个 LNMP 环境? (默认为N) | [N/y]: ${RESET}")" -i "N" answer
if [ "${answer,,}" = "y" ]; then
    # 检查是否存在容器
    if [ -n "$lnmp_allcontainer_ids" ]; then
        echo "系统中的所有Docker容器："
        echo "$lnmp_allcontainer_ids"
        
        echo "开始执行卸载操作..."
        
        for container_id in $lnmp_allcontainer_ids; do
            echo "正在卸载容器: $container_id"
            docker rm $container_id
        done
        
        echo "卸载操作完成"
        
    else
        echo "系统没有任何容器"
    fi
    
    # 检查是否存在镜像
    if [ -n "$lnmp_allimages_ids" ]; then
        echo "系统中的所有Docker镜像："
        echo "$lnmp_allimages_ids"
        
        echo "开始执行卸载操作..."
        
        for image_id in $lnmp_allimages_ids; do
            echo "正在删除镜像: $image_id"
            docker rmi $image_id
        done
        
        echo "卸载操作完成"
        
    else
        echo "系统没有任何镜像"
    fi
    
    # 检查是否存在网络
    if [ -n "$lnmp_allnetwork_ids" ]; then
        echo "系统中的所有Docker网络："
        echo "$lnmp_allnetwork_ids"
        
        echo "开始执行卸载操作..."
        
        for network_id in $lnmp_allnetwork_ids; do
            echo "正在删除网络: $network_id"
            docker network rm $network_id
        done
        
        echo "卸载操作完成"
        
    else
        echo "系统没有任何网络"
    fi
else
    echo "您已取消操作"
fi