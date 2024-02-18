#!/bin/bash


apt-get update

# 定义 PHP 版本
PHP_VERSION=8.3

# PHP 模块列表
PHP_MODULES=(
    bcmath
    bz2
    cli
    common
    curl
    fpm
    gd
    igbinary
    mbstring
    mysql
    opcache
    readline
    redis
    xml
    yaml
    zip
)

# 在容器内执行安装命令
for module in "${PHP_MODULES[@]}"; do
    apt-get install -y php8.3-${module}
done

# 重新加载 PHP 服务（如果需要）
service php8.3-fpm reload

echo "PHP 模块安装完成。"



