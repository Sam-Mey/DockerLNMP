#!/bin/bash

# 定义数据库容器
database_containers=("mysql" "mariadb" "mongodb" "sqlite")

# 定义 LNMP 容器
containers=("nginx" "${database_containers[@]}" "php" "redis" "phpmyadmin")

# 检查是否存在 LNMP 容器
lnmp_containers_exist=true
for container in "${containers[@]}"; do
    if ! docker ps -a --format '{{.Names}}' | grep -q "$container"; then
        lnmp_containers_exist=false
        break
    fi
done

cd /
git clone https://github.com/Sam-Mey/DockerLNMP.git
cp -r root/certs /DockerLNMP/www/server/nginx

cd /DockerLNMP/lnmp/build

git clone https://github.com/nginxinc/docker-nginx.git

git clone https://github.com/MariaDB/mariadb-docker.git
mv mariadb-docker docker-mariadb

git clone https://github.com/docker-library/php.git
mv php docker-php

git clone https://github.com/docker-library/redis.git
mv redis docker-redis

git clone https://github.com/phpmyadmin/docker.git
mv docker docker-phpmyadmin

find /DockerLNMP -name "*.sh" -exec chmod +x {} \;

chmod -R +x /DockerLNMP
cd /DockerLNMP/lnmp/build
docker-compose -f docker-compose.yml up

echo -e "\e[1;32m环境安装完成，您可以尝试访问公网IP地址：\e[1;34mhttp://IP_域名\e[1;32m 或 \e[1;34mhttps://IP_域名\e[0m"
