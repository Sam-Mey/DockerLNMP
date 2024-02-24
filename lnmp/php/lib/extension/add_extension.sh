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
apk add php83-bcmath
apk add php83-bz2
apk add php83-cli
apk add php83-common
apk add php83-curl
apk add php83-fpm
apk add php83-gd
apk add php83-mbstring
apk add php83-opcache
apk add php83-redis
apk add php83-xml
apk add php83-zip

apk add php83-igbinary # no, You need to clone the GitHub source code to compile and install
apk add php83-mysql # no, you need replace php83-mysqli
apk add php83-readline # no, You need to clone the GitHub source code to compile and install
apk add php83-yaml # no, You need to clone the GitHub source code to compile and install
#==============Alpine Extension==================

