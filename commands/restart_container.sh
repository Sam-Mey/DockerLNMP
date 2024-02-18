#!/bin/bash


docker restart sites-nginx-1
docker restart sites-mariadb-1
docker restart sites-php-1
docker restart sites-redis-1
docker restart sites-phpmyadmin-1

docker logs sites-nginx-1
docker logs sites-mariadb-1
docker logs sites-php-1
docker logs sites-redis-1
docker logs sites-phpmyadmin-1


