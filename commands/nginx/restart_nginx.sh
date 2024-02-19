#!/bin/bash

nginx_container_id=$(docker ps -qf "name=nginx")

# Nginx exist ?
if [ -n "$nginx_container_id" ]; then
    docker exec "$nginx_container_id" nginx -s reload
    
    echo "Nginx容器重新加载完成�?
else
    echo "Nginx容器未找到�?
fi
