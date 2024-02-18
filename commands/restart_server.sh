#!/bin/bash

# Include configuration
. /DockerLNMP/config.sh

# get container_ID
database_container_id=$(docker ps -qf "name=mysql" -f "name=mariadb" -f "name=mongodb" -f "name=sqlite")

nginx_container_id=$(docker ps -qf "name=nginx")
php_container_id=$(docker ps -qf "name=php")
phpmyadmin_container_id=$(docker ps -qf "name=phpmyadmin")
redis_container_id=$(docker ps -qf "name=redis")

# run restart
for container_id in $database_container_id; do
    if docker inspect "$container_id" > /dev/null 2>&1; then
        docker restart "$container_id"
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
