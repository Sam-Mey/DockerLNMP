#!/bin/bash
# 交互式地获取用户输入
read -p "Enter MySQL root password: " MYSQL_ROOT_PASSWORD
read -p "Enter MySQL database name: " MYSQL_DATABASE
read -p "Enter MySQL username: " MYSQL_USER
read -sp "Enter MySQL user password: " MYSQL_USER_PASSWORD
echo ""
# 导出环境变量
export MYSQL_DATABASE
export MYSQL_USER
# 输出设置的环境变量信息
echo "MySQL database name: $MYSQL_DATABASE"
echo "MySQL username: $MYSQL_USER"
# 可以输出其他设置的环境变量信息
# ...
# 将环境变量写入文件
echo "MYSQL_DATABASE=$MYSQL_DATABASE" > db_env.sh
echo "MYSQL_USER=$MYSQL_USER" >> db_env.sh
# 可以添加其他环境变量的写入操作
# ...
# 创建并写入 Secrets 变量
echo $MYSQL_ROOT_PASSWORD | docker secret create db_root_password -
echo $MYSQL_USER_PASSWORD | docker secret create db_user_password -
echo "MySQL root password has been written to Docker Secrets"
echo "MySQL user password has been written to Docker Secrets"