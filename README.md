# docker_lnmp

## 系统要求

### Ubuntu/Debian arm64

## 运行环境

> Nginx  
> MariaDB  
> PHP 8.2-fpm  
> Redis  
> phpMyAdmin

## 安装

```bash
curl -O https://raw.githubusercontent.com/Sam-Mey/docker_lnmp/main/install.sh
chmod +x install.sh
./install.sh
```

## PHP 默认模块列表；如需自定义，请修改 `install_php_modules.sh` 脚本

```bash
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
```

### 当前版本：v1.5.1

> 版本 v1.5.0 [环境能正常运行]  
> 版本 v1.5.1 [环境正常运行，并已配置SSL证书]  
> 版本 v2.5.0 [网站与环境能正常运行]
