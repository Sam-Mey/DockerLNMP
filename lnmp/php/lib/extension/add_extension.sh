#!/bash/bin

# PHP中安装扩展有几个特殊的命令
docker-php-source
docker-php-ext-install
docker-php-ext-enable
docker-php-ext-configure






# 需要安装的扩展
docker-php-ext-install bcmath
docker-php-ext-install bz2
docker-php-ext-install cli #
docker-php-ext-install common #
docker-php-ext-install curl
docker-php-ext-install fpm #
docker-php-ext-install gd
docker-php-ext-install igbinary #
docker-php-ext-install mbstring
docker-php-ext-install mysql #
docker-php-ext-install opcache
docker-php-ext-install readline
docker-php-ext-install redis # 
docker-php-ext-install xml
docker-php-ext-install yaml #
docker-php-ext-install zip
