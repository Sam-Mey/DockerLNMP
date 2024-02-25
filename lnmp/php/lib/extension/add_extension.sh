#!/bash/bin

# version php-alpine:3.19
# You need to go inside the PHP container

#============== Example ===================

# /var/www/html # apk search php-bcmath
# php81-bcmath-8.1.27-r0
# php82-bcmath-8.2.16-r0
# php83-bcmath-8.3.3-r0

# /var/www/html # apk add php83-bcmath
# (1/2) Installing php83-common (8.3.3-r0)
# (2/2) Installing php83-bcmath (8.3.3-r0)
# OK: 21 MiB in 39 packages

#============== Example ===================


#==============Alpine Extension==================
apt install php8.3-bcmath
apt install php8.3-bz2
apt install php8.3-cli
apt install php8.3-common
apt install php8.3-curl
apt install php8.3-fpm
apt install php8.3-gd
apt install php8.3-igbinary
apt install php8.3-mbstring
apt install php8.3-mysql
apt install php8.3-opcache
apt install php8.3-readline
apt install php8.3-redis
apt install php8.3-xml
apt install php8.3-yaml
apt install php8.3-zip
#==============Alpine Extension==================

./docker-php-ext-install bcmath bz2 cli common curl fpm gd igbinary mbstring mysql opcache readline redis xml yaml zip
