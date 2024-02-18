#!/bin/bash

redis_container_id=$(docker ps -qf "name=redis")

# redis exist ?
if [ -n "$redis_container_id" ]; then
    docker exec "$redis_container_id" redis -s reload
    
    echo "redis容器重新加载完成。"
else
    echo "redis容器未找到。"
fi