#!/bin/bash


docker exec -it server-php-1 /bin/sh -c "cd /usr/local/etc/php/conf.d && cat docker-php-ext-sodium.ini"



