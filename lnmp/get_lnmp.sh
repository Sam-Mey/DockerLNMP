#!/bin/bash

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

# 定义数据库容器
database_containers=("mysql" "mariadb" "mongodb" "sqlite")

# 定义 LNMP 容器
containers=("nginx" "${database_containers[@]}" "php" "redis" "phpmyadmin")

# 标记 LNMP 容器是否存在
lnmp_containers_exist=true

# 标记数据库容器是否存在
database_container_exist=false

# 遍历检查 LNMP 容器是否存在
for container in "${containers[@]}"; do
    if [ "$container" == "nginx" ] || [ "$container" == "php" ] || [ "$container" == "redis" ] || [ "$container" == "phpmyadmin" ]; then
        # 对于 "nginx"、"php"、"redis"、"phpmyadmin" 这四个容器，检查是否存在
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
    echo "${BOLD}${GREEN} LNMP 环境已创建。 ${RESET}"
    echo "${BOLD}${GREEN} 包含以下容器: ${RESET}"
    for container in "${containers[@]}"; do
        if [ "$container" != "mysql" ] && [ "$container" != "mongodb" ] && [ "$container" != "sqlite" ]; then
            echo "${BOLD}${GREEN} - $container ${RESET}"
        fi
    done
else
    echo -e "${BOLD}${RED} 系统中未创建完整的 LNMP 环境！！${RESET}"
    countdown 10
    if [ "$database_container_exist" = false ]; then
        echo "${BOLD}${RED} 数据库容器缺失: ${RESET}"
        for database_container in "${database_containers[@]}"; do
            echo "- $database_container 选 1"
        done
    fi
    echo -e "${BOLD}${RED} LNMP 容器缺失: ${RESET}"
    for container in "${containers[@]}"; do
        if ! docker ps -a --format '{{.Names}}' | grep -q "$container"; then
            echo "${BOLD}${RED} - $container ${RESET}"
        fi
    done
    
    # 如果 LNMP 容器缺失，执行其他脚本
    echo "${BOLD}${YELLOW} [创建 LNMP 环境] 即将调用安装命令... ${RESET}"
    countdown 10
    # 这里添加执行其他创建脚本的语句
    "$COMMAND_SCRIPT_PATH"
fi