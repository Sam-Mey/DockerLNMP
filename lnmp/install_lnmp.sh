#!/bin/bash

# 设置颜色变量
BOLD=$(tput bold)
RED=$(tput setaf 1)
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

# 提示用户是否安装 compose
if ! command -v docker-compose &> /dev/null; then
    read -p "您已安装 Docker，但未安装 Docker Compose。LNMP 环境需要 Docker Compose 支持，是否安装 Docker Compose？ (y/n): " install_compose
    if [ "$install_compose" == "y" ]; then
        # 执行 Docker Compose 安装脚本
    else
        echo "请先安装 Docker Compose 后再继续创建 LNMP 环境。"
        exit 1
    fi
fi

# 提示用户是否创建 LNMP
read -p "您已安装了 Docker 与 Docker Compose，符合创建 LNMP 环境的先决条件。是否继续创建 LNMP 环境？ (y/n): " create_lnmp
if [ "$create_lnmp" != "y" ]; then
    echo "LNMP 环境创建已取消。"
    exit 0
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
if [ "$lnmp_containers_exist" == false ]; then
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
