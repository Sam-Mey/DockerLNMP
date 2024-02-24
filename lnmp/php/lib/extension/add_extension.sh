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
apk add php82-bcmath
apk add php82-bz2
apk add php82-cli
apk add php82-common
apk add php82-curl
apk add php82-fpm
apk add php82-gd
apk add php82-mbstring
apk add php82-opcache
apk add php82-redis
apk add php82-xml
apk add php82-zip2

apk add php82-igbinary # no, You need to clone the GitHub source code to compile and install
apk add php82-mysql # no, you need replace php83-mysqli
apk add php82-readline # no, You need to clone the GitHub source code to compile and install
apk add php82-yaml # no, You need to clone the GitHub source code to compile and install
#==============Alpine Extension==================

