#!/bin/bash

# Include configuration
. /DockerLNMP/config.sh

# get container_ID
database_container_id=$(docker ps -qf "name=mysql" -f "name=mariadb" -f "name=mongodb" -f "name=sqlite")

container_id=$(docker ps -qf "name=nginx"  -f "name=php" -f "name=phpmyadmin" -f "name=redis")

# run restart
for database_container_id in $database_container_id; do
    if docker inspect "$container_id" > /dev/null 2>&1; then
        docker restart "$database_container_id"
    else
        echo "容器 $container_id 不存在或无法访问。"
    fi
done

for container_id in $nginx_container_id $php_container_id $phpmyadmin_container_id $redis_container_id; do
    if docker inspect "$container_id" > /dev/null 2>&1; then
        docker restart "$container_id"
    else
        echo "容器 $container_id 不存在或无法访问。"
    fi
done

echo "容器已重启完成。"
