#!/bin/bash

php_container_id=$(docker ps -qf "name=php")

# php exist ?
if [ -n "$php_container_id" ]; then
    docker exec "$php_container_id" php -s reload
    
    echo "php容器重新加载完成"
else
    echo "php容器未找到"
fi
