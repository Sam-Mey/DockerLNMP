#!/bin/bash


cd /
git clone https://github.com/Sam-Mey/DockerLNMP.git
cp -r root/certs /DockerLNMP/www/server/nginx

cd /DockerLNMP/lnmp/builde

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
cd /DockerLNMP/lnmp/builde
docker-compose -f docker-compose.yml up

echo -e "\e[1;32m环境安装完成，您可以尝试访问公网IP地址：\e[1;34mhttp://IP_域名\e[1;32m 或 \e[1;34mhttps://IP_域名\e[0m"
