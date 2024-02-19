#!/bin/bash

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
    echo "LNMP 环境已创建。"
    echo "包含以下容器:"
    for container in "${containers[@]}"; do
        if [ "$container" != "mysql" ] && [ "$container" != "mongodb" ] && [ "$container" != "sqlite" ]; then
            echo "- $container"
        fi
    done
else
    echo "系统中未创建完整的 LNMP 环境！！"
    if [ "$database_container_exist" = false ]; then
        echo "数据库容器缺失:"
        for database_container in "${database_containers[@]}"; do
            echo "- $database_container 选 1"
        done
    fi
    echo "LNMP 容器缺失:"
    for container in "${containers[@]}"; do
        if ! docker ps -a --format '{{.Names}}' | grep -q "$container"; then
            echo "- $container"
        fi
    done
    
    # 如果 LNMP 容器缺失，执行其他脚本
    echo "调用安装命令..."
    # 这里添加执行其他创建脚本的语句
    "$COMMAND_SCRIPT_PATH"
fi
