#!/bin/bash

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

# 检查系统是否安装 Docker
if ! command -v docker &> /dev/null; then
    echo -e "${RED}未安装 Docker !!! 即将为您安装 Docker...${RESET}"
    # 执行 Docker 安装脚本
fi

# 检查系统是否安装 Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}未安装 Docker Compose !!! 即将为您安装 Docker Compose...${RESET}"
    # 执行 Docker Compose 安装脚本
fi

# 定义数据库容器
database_containers=("mysql" "mariadb" "mongodb" "sqlite")

# 定义 LNMP 容器
containers=("nginx" "${database_containers[@]}" "php" "redis" "phpmyadmin")

# 检查是否存在 LNMP 容器
lnmp_containers_exist=true
for container in "${containers[@]}"; do
    if ! docker ps -a --format '{{.Names}}' | grep -q "$container"; then
        lnmp_containers_exist=false
        break
    fi
done

# 如果 LNMP 容器不存在，执行创建脚本
if [ "$lnmp_containers_exist" = false ]; then
    echo "您尚未创建 LNMP 环境，即将为您创建..."
    # 执行 LNMP 创建脚本
else
    echo "您已创建了 LNMP 环境，无需再次创建。"
    echo "包含以下容器:"
    for container in "${containers[@]}"; do
        echo "- $container"
    done
    exit
fi
