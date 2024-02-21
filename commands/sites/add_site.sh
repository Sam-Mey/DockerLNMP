#!/bin/bash

# Include configuration
. /DockerLNMP/config.sh

# Define colors and styles using tput
BOLD=$(tput bold)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

# 获取用户输入，使用 -r 参数禁用反斜杠转义
read -r -p "${BOLD}${GREEN}请输入站点域名: ${RESET}" site_domain

# 指定站点文件夹路径
base_path="DockerLNMP/www/sites"

# 检查文件夹是否存在，如果不存在则创建
site_folder="$base_path/$site_domain"
if [ ! -d "$site_folder" ]; then
    mkdir -p "$site_folder"
    echo "${BOLD}${GREEN} 站点创建成功：$site_folder ${RESET}"
else
    echo "${BOLD}${RED} 站点已存在：$site_folder ${RESET}"
fi

# 使用站点文件夹作为默认URL
site_url="$base_path/$site_domain"

echo -e "${BOLD}${RED}\n成功添加站点！你可手动进入站点目录上传网站源码：${RESET}"
echo "${BOLD}${GREEN}域名:${RESET} ${YELLOW} $site_domain ${RESET}"
echo "${BOLD}${GREEN}站点目录 URL:${RESET} ${YELLOW} $site_url ${RESET}"