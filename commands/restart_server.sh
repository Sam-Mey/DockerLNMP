# #!/bin/bash

# # Include configuration
# . /DockerLNMP/config.sh

# # get container_ID
# database_container_id=$(docker ps -qf "name=mysql" -f "name=mariadb" -f "name=mongodb" -f "name=sqlite")

# nginx_container_id=$(docker ps -qf "name=nginx")
# php_container_id=$(docker ps -qf "name=php")
# phpmyadmin_container_id=$(docker ps -qf "name=phpmyadmin")
# redis_container_id=$(docker ps -qf "name=redis")

# # run restart
# for container_id in $database_container_id; do
#     if docker inspect "$container_id" > /dev/null 2>&1; then
#         docker restart "$container_id"
#     else
#         echo "容器 $container_id 不存在或无法访问。"
#     fi
# done

# # run restart
# for container_id in $nginx_container_id $php_container_id $phpmyadmin_container_id $redis_container_id; do
#     if docker inspect "$container_id" > /dev/null 2>&1; then
#         docker restart "$container_id"
#     else
#         echo "容器 $container_id 不存在或无法访问。"
#     fi
# done

# # 这里不能直接打印，代码执行完成后检查每个容器是否重启成功才能
# echo "所有容器已重启完成。"



#!/bin/bash

# 设置脚本所在目录为当前工作目录
cd "$(dirname "${BASH_SOURCE[0]}")" || exit

# Include configuration
. /DockerLNMP/config.sh

# get container_ID
database_container_id=$(docker ps -qf "name=mysql" -f "name=mariadb" -f "name=mongodb" -f "name=sqlite")

nginx_container_id=$(docker ps -qf "name=nginx")
php_container_id=$(docker ps -qf "name=php")
phpmyadmin_container_id=$(docker ps -qf "name=phpmyadmin")
redis_container_id=$(docker ps -qf "name=redis")

# Function to restart container
restart_container() {
    local container_id=$1
    if docker inspect "$container_id" > /dev/null 2>&1; then
        docker restart "$container_id"
        return 0  # Success
    else
        echo "容器 $container_id 不存在或无法访问。"
        return 1  # Failure
    fi
}

# Restart database containers
for container_id in $database_container_id; do
    restart_container "$container_id"
    status=$?
    if [ $status -eq 0 ]; then
        echo "容器 $container_id 已成功重启。"
    fi
done

# Restart other containers
all_containers=($nginx_container_id $php_container_id $phpmyadmin_container_id $redis_container_id)
success_count=0

for container_id in "${all_containers[@]}"; do
    restart_container "$container_id"
    status=$?
    if [ $status -eq 0 ]; then
        echo "容器 $container_id 已成功重启。"
        ((success_count++))
    fi
done

# Check if all containers were successfully restarted
if [ $success_count -eq ${#all_containers[@]} ]; then
    echo "所有容器已重启完成。"
else
    echo "部分容器重启失败。请检查日志以获取详细信息。"
fi
