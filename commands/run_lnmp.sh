#!/bin/bash

# Clone DockerLNMP repository
cd /
git clone https://github.com/Sam-Mey/DockerLNMP.git

# Change directory to the DockerLNMP folder
cd /DockerLNMP/lnmp

# Clone necessary repositories and move them
cd nginx && git clone https://github.com/nginxinc/docker-nginx.git && cd ..
cd mariadb && git clone https://github.com/MariaDB/mariadb-docker.git && mv mariadb-docker docker-mariadb && cd ..
cd php && git clone https://github.com/docker-library/php.git && mv php docker-php && cd ..
cd phpmyadmin && git clone https://github.com/phpmyadmin/docker.git && mv docker docker-phpmyadmin && cd ..
cd redis && git clone https://github.com/docker-library/redis.git && mv redis docker-redis && cd ..

# Set execute permissions for shell scripts
find /DockerLNMP -name "*.sh" -exec chmod +x {} \;

# Set execute permissions for DockerLNMP directory
chmod -R +x /DockerLNMP

# Change directory to DockerLNMP 
cd /DockerLNMP/lnmp

# Bring up the Docker Compose environment
docker-compose -f docker-compose.yml up

# Print completion message
echo -e "\e[1;32m环境安装完成，您可以尝试访问公网IP地址：\e[1;34mhttp://IP_域名\e[1;32m 或 \e[1;34mhttps://IP_域名\e[0m"
