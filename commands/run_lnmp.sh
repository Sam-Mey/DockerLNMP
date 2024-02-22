#!/bin/bash

# Clone DockerLNMP repository
cd /
git clone https://github.com/Sam-Mey/DockerLNMP.git

# Copy certs directory to nginx server
# cp -r root/certs /DockerLNMP/www/server/nginx

# Change directory to the  folder
cd /DockerLNMP/lnmp

# Clone necessary repositories
# git clone https://github.com/nginxinc/docker-nginx.git
# git clone https://github.com/MariaDB/mariadb-docker.git
# mv mariadb-docker docker-mariadb
# git clone https://github.com/docker-library/php.git
# mv php docker-php
# git clone https://github.com/docker-library/redis.git
# mv redis docker-redis
# git clone https://github.com/phpmyadmin/docker.git
# mv docker docker-phpmyadmin

# Set execute permissions for shell scripts
find /DockerLNMP -name "*.sh" -exec chmod +x {} \;

# Set execute permissions for DockerLNMP directory
chmod -R +x /DockerLNMP

# Change directory to DockerLNMP 
cd /DockerLNMP/lnmp

# Bring up the Docker Compose environment
docker stack deploy -c docker-compose.yml lnmp-stack

# Print completion message
echo -e "\e[1;32m环境安装完成，您可以尝试访问公网IP地址：\e[1;34mhttp://IP_域名\e[1;32m 或 \e[1;34mhttps://IP_域名\e[0m"
