#!/bin/bash

docker exec -it server-php-1 /bin/sh -c "cd /usr/local/etc/php && cat php.ini-production"
