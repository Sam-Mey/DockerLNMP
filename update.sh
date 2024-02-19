#!/bin/bash

# 保存当前目录
current_dir=$(pwd)

# 克隆远程仓库
git clone https://github.com/Sam-Mey/DockerLNMP.git tmp_DockerLNMP

# 切换�?DockerLNMP目录
cd /DockerLNMP || exit

# 拉取远程仓库的最新变�?
git fetch --quiet origin

# 重置本地仓库到最新的提交
git reset --quiet --hard origin/main

# 将所�?.sh 文件添加执行权限
find . -name "*.sh" -exec chmod +x {} \;

# 创建符号链接，使�?'dlnmp' 命令指向 menu.sh
ln -sf "/DockerLNMP/menu.sh" "/usr/local/bin/dlnmp"

# 用最新内容替换当前目录的文件
rsync -av --exclude='.git' tmp_DockerLNMP/ .

# 切换回原始目�?
cd "$current_dir" || exit

# 清理临时目录
rm -rf tmp_DockerLNMP

# 运行 'dlnmp' 命令（确�?'dlnmp' 在这一步之前已经设置好�?
dlnmp

# debug
# echo "Cloning the repository..."
# echo "Fetching the latest changes..."
# echo "Resetting local repository to the latest commit..."
# echo "Adding execute permissions to .sh files..."
# echo "Creating symbolic link for menu.sh..."
# echo "Replacing current content with updated content..."
# echo "Cleaning up temporary directory..."
# echo "Running 'et' command..."
