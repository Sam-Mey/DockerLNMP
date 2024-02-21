#!/bin/bash

# Include configuration
. /DockerLNMP/config.sh

# Define colors and styles, use tput
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

# get container_ID
database_container_id=$(docker ps -aqf "name=mysql" -f "name=mariadb" -f "name=mongodb" -f "name=sqlite")
nginx_container_id=$(docker ps -aqf "name=nginx")
php_container_id=$(docker ps -aqf "name=php")
phpmyadmin_container_id=$(docker ps -aqf "name=phpmyadmin")
redis_container_id=$(docker ps -aqf "name=redis")
jemalloc_container_id=$(docker ps -aqf "name=jemalloc") # About Redis memory allocator

# Function to restart container
restart_container() {
    local container_id=$1
    if docker inspect "$container_id" > /dev/null 2>&1; then
        docker restart "$container_id"
        return 0  # Success
    else
        echo -e  "${BOLD}${RED} 容器 $container_id 不存在或无法访问 ${RESET}"
        return 1  # Failure
    fi
}

# Restart database containers
for container_id in $database_container_id; do
    restart_container "$container_id"
    if [ $? -eq 0 ]; then
        echo -e "${BOLD}${GREEN}容器${RESET} ${RED}${BLINK}$container_id${RESET} ${BOLD}${GREEN}已成功重启 ${RESET}"
    else
        echo -e "${BOLD}${RED}容器${RESET} ${RED}$container_id${RESET} ${BOLD}${GREEN}重启失败${RESET}"
    fi
done

# Restart other containers
all_containers=($nginx_container_id $php_container_id $phpmyadmin_container_id $redis_container_id $jemalloc_container_id)
success_count=0

for container_id in "${all_containers[@]}"; do
    restart_container "$container_id"
    if [ $? -eq 0 ]; then
        echo -e "${BOLD}${GREEN}容器${RESET} ${RED}${BLINK}$container_id${RESET} ${BOLD}${GREEN}已成功重启 ${RESET}"
        ((success_count++))
    else
        echo -e "${BOLD}${RED}容器${RESET} ${RED}$container_id${RESET} ${BOLD}${GREEN}重启失败${RESET}"
    fi
done

# Check if all containers were successfully restarted
if [ $success_count -eq ${#all_containers[@]} ]; then
    echo -e "${BOLD}${PURPLE} 所有容器已重启完成 ${RESET}"
else
    echo -e "${BOLD}${RED} 部分容器重启失败。请检查日志以获取详细信息 ${RESET}"
fi