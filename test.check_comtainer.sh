#!/bin/bash

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