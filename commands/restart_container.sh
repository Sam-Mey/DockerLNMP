#!/bin/bash

# get container_ID
database_container_id=$(docker ps -qf "name=mysql" -f "name=mariadb" -f "name=mongodb" -f "name=sqlite")

nginx_container_id=$(docker ps -qf "name=nginx")
php_container_id=$(docker ps -qf "name=php")
phpmyadmin_container_id=$(docker ps -qf "name=phpmyadmin")
redis_container_id=$(docker ps -qf "name=redis")

# run restart
for container_id in "$database_container_id"; do
    docker restart "$container_id"
done

for container_id in "$nginx_container_id" "$php_container_id" "$phpmyadmin_container_id" "$redis_container_id"; do
    docker restart "$container_id"
done

echo "容器已重启完成。"
