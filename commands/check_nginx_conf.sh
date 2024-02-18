#!/bin/bash

# 找到nginx容器的ID
nginx_container_id=$(docker ps -qf "name=nginx")

if [ -n "$nginx_container_id" ]; then
    # 进入nginx容器并查找default.conf
    nginx_conf_path=$(docker exec -it "$nginx_container_id" find / -name "default.conf" -print -quit | tr -d '\r')
    
    if [ -n "$nginx_conf_path" ]; then
        # 在nginx容器内使用cat命令打开default.conf
        docker exec -it "$nginx_container_id" cat "$nginx_conf_path"
    else
        echo "default.conf not found in the Nginx container."
    fi
else
    echo "Nginx container not found."
fi
