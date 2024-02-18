#!/bin/bash


docker restart build-nginx-1
docker restart build-mariadb-1
docker restart build-php-1
docker restart build-redis-1
docker restart build-phpmyadmin-1

docker logs build-nginx-1
docker logs build-mariadb-1
docker logs build-php-1
docker logs build-redis-1
docker logs build-phpmyadmin-1


