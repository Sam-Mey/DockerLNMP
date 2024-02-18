#!/bin/bash

# 找到nginx容器的ID
nginx_container_id=$(docker ps -qf "name=nginx")

if [ -n "$nginx_container_id" ]; then
    # 进入nginx容器并查找default.conf
    docker exec -it "$nginx_container_id" find / -name "default.conf" -print -quit
else
    echo "Nginx container not found."
fi
