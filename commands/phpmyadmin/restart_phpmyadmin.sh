#!/bin/bash

phpmyadmin_container_id=$(docker ps -qf "name=phpmyadmin")

# phpmyadmin exist ?
if [ -n "$phpmyadmin_container_id" ]; then
    docker exec "$phpmyadmin_container_id" phpmyadmin -s reload
    
    echo "phpmyadmin容器重新加载完成�?
else
    echo "phpmyadmin容器未找到�?
fi
