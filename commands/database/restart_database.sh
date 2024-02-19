#!/bin/bash

database_container_id=$(docker ps -qf "name=mysql" -f "name=mariadb" -f "name=mongodb" -f "name=sqlite")

# database exist ?
if [ -n "$database_container_id" ]; then
    docker exec "$database_container_id" database -s reload
    
    echo "database容器重新加载完成"
else
    echo "database容器未找到"
fi
