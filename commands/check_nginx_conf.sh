#!/bin/bash

nginx_container_id=$(docker ps -aqf "name=nginx")

if [ -n "$nginx_container_id" ]; then
    nginx_conf_path=$(docker exec -it "$nginx_container_id" find / -name "default.conf" -print -quit | tr -d '\r')
    
    if [ -n "$nginx_conf_path" ]; then
        docker exec -it "$nginx_container_id" cat "$nginx_conf_path"
    else
        echo "default.conf not found in the Nginx container."
    fi
else
    echo "Nginx container not found."
fi
