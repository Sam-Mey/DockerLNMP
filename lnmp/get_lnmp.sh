#!/bin/bash

# 定义 countdown 函数
function countdown {
    local seconds=$1
    
    while [ $seconds -gt 0 ]; do
        echo -e "${WHITE}" "倒计�? $seconds 秒后 调用安装命令... ${RESET}"
        sleep 1
        ((seconds--))
    done
}

# Include configuration
. /DockerLNMP/config.sh

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

# 定义数据库容�?
database_containers=("mysql" "mariadb" "mongodb" "sqlite")

# 定义 LNMP 容器
containers=("nginx" "${database_containers[@]}" "php" "redis" "phpmyadmin")

# 标记 LNMP 容器是否存在
lnmp_containers_exist=true

# 标记数据库容器是否存�?
database_container_exist=false

# 遍历检�?LNMP 容器是否存在
for container in "${containers[@]}"; do
    if [ "$container" == "nginx" ] || [ "$container" == "php" ] || [ "$container" == "redis" ] || [ "$container" == "phpmyadmin" ]; then
        # 对于 "nginx"�?php"�?redis"�?phpmyadmin" 这四个容器，检查是否存�?
        if ! docker ps -a --format '{{.Names}}' | grep -q "$container"; then
            lnmp_containers_exist=false
        fi
    else
        # 对于数据库容器，只要有一个存在，就标记为存在
        if docker ps -a --format '{{.Names}}' | grep -q "$container"; then
            database_container_exist=true
        fi
    fi
done

# 判断 LNMP 容器是否存在且数据库容器存在
if [ "$lnmp_containers_exist" = true ] && [ "$database_container_exist" = true ]; then
    echo "${BOLD}${YELLOW} LNMP 环境已创建�?${RESET}"
    echo "${BOLD}${YELLOW} 包含以下容器: ${RESET}"
    for container in "${containers[@]}"; do
        if [ "$container" != "mysql" ] && [ "$container" != "mongodb" ] && [ "$container" != "sqlite" ]; then
            echo "${GREEN} - $container ${RESET}"
        fi
    done
else
    echo -e "${BOLD}${YELLOW} 系统中未创建完整�?LNMP 环境！！${RESET}"
    if [ "$database_container_exist" = false ]; then
        echo "${BOLD}${YELLOW} 数据库容器缺�? ${RESET}"
        for database_container in "${database_containers[@]}"; do
            echo "${RED}- $database_container �?1 ${RESET}"
        done
    fi
    echo -e "${BOLD}${YELLOW} LNMP 容器缺失: ${RESET}"
    for container in "${containers[@]}"; do
        if ! docker ps -a --format '{{.Names}}' | grep -q "$container"; then
            echo "${RED} - $container ${RESET}"
        fi
    done
    
    echo "${BOLD}${YELLOW} [创建 LNMP 环境] ... ${RESET}"
    
    countdown 10
    "$COMMAND_SCRIPT_PATH"
fi
