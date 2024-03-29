# 需要安装的扩展
```bash
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
```

# Docker 中的PHP容器安装扩展的方式有
## 1.通过pecl方式安装
## 2.通过php 容器中自带的几个特殊命令来安装，这些特殊命令可以在Dockerfile中的RUN命令中进行使用。


# Docker-PHP中安装扩展有几个特殊的命令
```bash
docker-php-source
docker-php-ext-install
docker-php-ext-enable
docker-php-ext-configure
```

## 这三个命令的作用,都是在PHP容器中进行演示的，PHP容器启动太简单，不作过多介绍
```bash
docker-php-source
```

> 此命令，实际上就是在PHP容器中创建一个 `/usr/src/php` 的目录，里面放了一些自带的文件而已。
> 我们就把它当作一个从互联网中下载下来的PHP扩展源码的存放目录即可。
> 事实上，所有PHP扩展源码扩展存放的路径：`/usr/src/php/ext` 里面。
> 创建与删除 `docker-php-source extract | delete`
>  
> 参数说明：
> * extract : 创建并初始化 `/usr/src/php` 目录
> * delete : 删除 `/usr/src/php` 目录

## 案例
```bash
root@803cbcf702a4:/usr/src# ls -l
total 11896 #此时，并没有php目录
-rw-r--r-- 1 root root 12176404 Jun 28 03:23 php.tar.xz
-rw-r--r-- 1 root root      801 Jun 28 03:23 php.tar.xz.asc

root@803cbcf702a4:/usr/src# docker-php-source extract
root@803cbcf702a4:/usr/src# ls -l
total 11900 #此时，生产了php目录，里面还有一些文件，由于篇幅问题，就不进去查看了
drwxr-xr-x 14 root root     4096 Aug  9 09:01 php
-rw-r--r--  1 root root 12176404 Jun 28 03:23 php.tar.xz
-rw-r--r--  1 root root      801 Jun 28 03:23 php.tar.xz.asc

root@803cbcf702a4:/usr/src# docker-php-source delete
root@803cbcf702a4:/usr/src# ls -l
total 11896 #此时，将已创建 php 目录给删除了
-rw-r--r-- 1 root root 12176404 Jun 28 03:23 php.tar.xz
-rw-r--r-- 1 root root      801 Jun 28 03:23 php.tar.xz.asc

root@803cbcf702a4:/usr/src#
```
```bash
docker-php-ext-install
```
> 这个命令，是用来安装并启动PHP扩展的。
> 命令格式：
> `docker-php-ext-install` “源码包目录名”
>  
> 注意点：
>  
> “源码包“需要放在 `/usr/src/php/ext` 下
> 默认情况下，PHP容器没有 `/usr/src/php` 这个目录，需要使用 `docker-php-source extract` 来生成。
> `docker-php-ext-install` 安装的扩展在安装完成后，会自动调用 `docker-php-ext-enable` 来启动安装的扩展。
> 卸载扩展，直接删除 `/usr/local/etc/php/conf.d` 对应的配置文件即可。

## 案例
```bash
# 卸载redis 扩展
root@803cbcf702a4:/usr/local# rm -rf /usr/local/etc/php/conf.d/docker-php-ext-redis.ini
root@803cbcf702a4:/usr/local# php -m 
[PHP Modules]
Core
ctype
curl
date
dom
fileinfo
filter
ftp
hash
iconv
json
libxml
mbstring
mysqlnd
openssl
pcre
PDO
pdo_sqlite
Phar
posix
readline
Reflection
session
SimpleXML
sodium
SPL
sqlite3
standard
tokenizer
xml
xmlreader
xmlwriter
zlib

[Zend Modules]

root@803cbcf702a4:/usr/local#

#PHP容器默认是没有redis扩展的。所以我们通过docker-php-ext-install安装redis扩展

root@803cbcf702a4:/# curl -L -o /tmp/reids.tar.gz https://codeload.github.com/phpredis/phpredis/tar.gz/5.0.2

root@803cbcf702a4:/# cd /tmp
root@517b9c67507a:/tmp# tar -xzf reids.tar.gz
root@517b9c67507a:/tmp# ls
phpredis-5.0.2	reids.tar.gz
root@517b9c67507a:/tmp# docker-php-source extract
root@517b9c67507a:/tmp# mv phpredis-5.0.2 /usr/src/php/ext/phpredis

#检查移过去的插件源码包是否存在
root@517b9c67507a:/tmp# ls -l /usr/src/php/ext | grep redis
drwxrwxr-x  6 root root 4096 Jul 29 15:04 phpredis
root@517b9c67507a:/tmp# docker-php-ext-install phpredis

# 检查redis 扩展是否已经安装上
root@517b9c67507a:/tmp# php -m | grep redis
redis
root@517b9c67507a:/tmp#
```

```bash
docker-php-ext-enable
```
> 这个命令，就是用来启动 PHP扩展 的。
> 我们使用pecl安装PHP扩展的时候，默认是没有启动这个扩展的，如果想要使用这个扩展必须要在php.ini这个配置文件中去配置一下才能使用这个PHP扩展。
> 而 docker-php-ext-enable 这个命令则是自动给我们来启动PHP扩展的，不需要你去php.ini这个配置文件中去配置。

## 案例
```bash
# 查看现有可以启动的扩展
root@517b9c67507a:/usr/local/etc/php# ls /usr/local/lib/php/extensions/no-debug-non-zts-20170718/
opcache.so  redis.so  sodium.so
root@517b9c67507a:/usr/local/etc/php#

# 查看redis 扩展是否可以启动
root@517b9c67507a:/usr/local/etc/php# php -m | grep redis
root@517b9c67507a:/usr/local/etc/php#

# 启动 redis 扩展
root@517b9c67507a:/usr/local/etc/php# docker-php-ext-enable redis
# 启动 成功
root@517b9c67507a:/usr/local/etc/php# php -m | grep redis
redis
root@517b9c67507a:/usr/local/etc/php#

#说明，php容器中默认是没有php.ini配置文件的,加载原理如下所示

root@517b9c67507a:/usr/local/etc/php# php -i | grep -A 5 php.ini
Configuration File (php.ini) Path => /usr/local/etc/php
Loaded Configuration File => (none)
# 核心是 /usr/local/etc/php/conf.d 目录下的扩展配置文件
Scan this dir for additional .ini files => /usr/local/etc/php/conf.d
Additional .ini files parsed => /usr/local/etc/php/conf.d/docker-php-ext-redis.ini,
/usr/local/etc/php/conf.d/docker-php-ext-sodium.ini

root@517b9c67507a:/usr/local/etc/php#
```

```bash
docker-php-ext-configure
```
> `docker-php-ext-configure` 一般都是需要跟 docker-php-ext-install搭配使用的。
> 它的作用就是，当你安装扩展的时候，需要自定义配置时，就可以使用它来帮你做到。

## 案例
```bash
FROM php:7.1-fpm
RUN apt-get update \
	# 相关依赖必须手动安装
	&& apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
    # 安装扩展
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    # 如果安装的扩展需要自定义配置时
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
```

# 演示

## 1.安装pdo_mysql扩展
```bash
docker-php-ext-install pdo_mysql
```
## 2.安装redis扩展
```bash
docker-php-ext-install redis
```
> 报错，为什么？ 
> 因为你的 `/usr/src/php/ext` 目录下跟没有这个扩展，看`pdo`信息！
> 那现在要干什么，当然是要去下载，然后解压到这个目录里，再执行上面的命令。
> 安装完成后重启下php，然后看`pdo`信息。
> 查看`pdo`信息需要创建一个 `index.php` 放在网站目录，里面写 `<?php phpinfo ?>` !


