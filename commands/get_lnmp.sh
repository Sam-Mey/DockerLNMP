#!/bin/bash

# Define countdown function
function countdown {
    local seconds=$1
    
    while [ $seconds -gt 0 ]; do
        echo -e "${WHITE}" "倒计时 $seconds 秒后 调用安装命令... ${RESET}"
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

database_containers=("mysql" "mariadb" "mongodb" "sqlite")

# Define LNMP container
containers=("nginx" "${database_containers[@]}" "php" "redis" "phpmyadmin")

# Mark whether the LNMP container exists
lnmp_containers_exist=true

# Mark whether the database container exists
database_container_exist=false

# Traverse to check whether the LNMP container exists
for container in "${containers[@]}"; do
    if [ "$container" == "nginx" ] || [ "$container" == "php" ] || [ "$container" == "redis" ] || [ "$container" == "phpmyadmin" ]; then
        # For the four containers "nginx" "php" "redis" "phpmyadmin", check whether they exist
        if ! docker ps -a --format '{{.Names}}' | grep -q "$container"; then
            lnmp_containers_exist=false
        fi
    else
        # For any other container, if it exists, set lnmp_containers_exist to false
        if docker ps -a --format '{{.Names}}' | grep -q "$container"; then
            lnmp_containers_exist=false
        fi
    fi
done

# Determine whether the LNMP container exists and the database container exists
if [ "$lnmp_containers_exist" = true ] && [ "$database_container_exist" = true ]; then
    echo "${BOLD}${YELLOW} LNMP 环境已创建 ${RESET}"
    echo "${BOLD}${YELLOW} 包含以下容器: ${RESET}"
    for container in "${containers[@]}"; do
        if [ "$container" != "mysql" ] && [ "$container" != "mongodb" ] && [ "$container" != "sqlite" ]; then
            echo "${GREEN} - $container ${RESET}"
        fi
    done
else
    echo -e "${BOLD}${YELLOW} 系统中未创建完整 LNMP 环境！！${RESET}"
    if [ "$database_container_exist" = false ]; then
        echo "${BOLD}${YELLOW} 数据库容器缺失 ${RESET}"
        for database_container in "${database_containers[@]}"; do
            echo "${RED}- $database_container 选 1 ${RESET}"
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
    "$RUN_LNMP_SCRIPT_PATH"
fi
