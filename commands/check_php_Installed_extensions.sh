#!/bin/bash


docker exec -it server-php-1 /bin/sh -c "cd / && php -m"

# 查看扩展详细信息
# php -i


