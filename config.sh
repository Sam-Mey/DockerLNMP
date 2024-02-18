#!/bin/bash

# 切换到脚本所在目录
cd "$(dirname "${BASH_SOURCE[0]}")"

# 保存脚本所在目录的路径
SCRIPT_DIR="/DockerLNMP"

DDSYSTEM_SCRIPT_PATH="$SCRIPT_DIR/docker/DDSystem.sh"
ADD_SITE_SCRIPT_PATH="$SCRIPT_DIR/commands/add_site.sh"
CENTOS_SCRIPT_PATH="$SCRIPT_DIR/docker/centos.sh"
CHECK_NGINX_CONF_SCRIPT_PATH="$SCRIPT_DIR/commands/check_nginx_conf.sh"
CHECK_PHP_INSTALLED_EXTENSIONS_SCRIPT_PATH="$SCRIPT_DIR/commands/check_php_Installed_extensions.sh"
CHECK_PHP_DISABLE_FUNCTIONS_SCRIPT_PATH="$SCRIPT_DIR/commands/check_php_disable_functions.sh"
CHECK_PHP_ENTERED_EXTENSIONS_SCRIPT_PATH="$SCRIPT_DIR/commands/check_php_entered_extensions.sh"
COMPOSE_SCRIPT_PATH="$SCRIPT_DIR/docker/compose.sh"
CONFIG_SCRIPT_PATH="$SCRIPT_DIR/config.sh"
CONTAINER_LOGS_MENU_SCRIPT_PATH="$SCRIPT_DIR/submenu/container_logs_menu.sh"
CONTAINER_MENU_SCRIPT_PATH="$SCRIPT_DIR/submenu/container_menu.sh"
DOCKER_SCRIPT_PATH="$SCRIPT_DIR/docker/docker.sh"
INSTALL_SCRIPT_PATH="$SCRIPT_DIR/install.sh"
INSTALL_LNMP_SCRIPT_PATH="$SCRIPT_DIR/lnmp/install_lnmp.sh"
INSTALL_PHP_EXTENSIONS_SCRIPT_PATH="$SCRIPT_DIR/commands/install_php_extensions.sh"
LNMP_MENU_SCRIPT_PATH="$SCRIPT_DIR/submenu/lnmp_menu.sh"
MENU_SCRIPT_PATH="$SCRIPT_DIR/menu.sh"
RESTART_CONTAINER_SCRIPT_PATH="$SCRIPT_DIR/commands/restart_container.sh"
UBUNTU_DEBIAN_SCRIPT_PATH="$SCRIPT_DIR/docker/ubuntu_debian.sh"
UBUNTU_DEBIAN_ARM64_SCRIPT_PATH="$SCRIPT_DIR/docker/ubuntu_debian_arm64.sh"
UNINSTALL_SCRIPT_PATH="$SCRIPT_DIR/uninstall.sh"
UNINSTALL_LNMP_SCRIPT_PATH="$SCRIPT_DIR/lnmp/uninstall_lnmp.sh"
UPDATE_SCRIPT_PATH="$SCRIPT_DIR/update.sh"

# 其他配置...

# 路径调试信息
# echo "DDSYSTEM_SCRIPT_PATH: $DDSYSTEM_SCRIPT_PATH"
# echo "ADD_SITE_SCRIPT_PATH: $ADD_SITE_SCRIPT_PATH"
# echo "CENTOS_SCRIPT_PATH: $CENTOS_SCRIPT_PATH"
# echo "CHECK_NGINX_CONF_SCRIPT_PATH: $CHECK_NGINX_CONF_SCRIPT_PATH"
# echo "CHECK_PHP_INSTALLED_EXTENSIONS_SCRIPT_PATH: $CHECK_PHP_INSTALLED_EXTENSIONS_SCRIPT_PATH"
# echo "CHECK_PHP_DISABLE_FUNCTIONS_SCRIPT_PATH: $CHECK_PHP_DISABLE_FUNCTIONS_SCRIPT_PATH"
# echo "CHECK_PHP_ENTERED_EXTENSIONS_SCRIPT_PATH: $CHECK_PHP_ENTERED_EXTENSIONS_SCRIPT_PATH"
# echo "COMPOSE_SCRIPT_PATH: $COMPOSE_SCRIPT_PATH"
# echo "CONFIG_SCRIPT_PATH: $CONFIG_SCRIPT_PATH"
# echo "CONTAINER_LOGS_MENU_SCRIPT_PATH: $CONTAINER_LOGS_MENU_SCRIPT_PATH"
# echo "CONTAINER_MENU_SCRIPT_PATH: $CONTAINER_MENU_SCRIPT_PATH"
# echo "DOCKER_SCRIPT_PATH: $DOCKER_SCRIPT_PATH"
# echo "INSTALL_SCRIPT_PATH: $INSTALL_SCRIPT_PATH"
# echo "INSTALL_LNMP_SCRIPT_PATH: $INSTALL_LNMP_SCRIPT_PATH"
# echo "INSTALL_PHP_EXTENSIONS_SCRIPT_PATH: $INSTALL_PHP_EXTENSIONS_SCRIPT_PATH"
# echo "LNMP_MENU_SCRIPT_PATH: $LNMP_MENU_SCRIPT_PATH"
# echo "MENU_SCRIPT_PATH: $MENU_SCRIPT_PATH"
# echo "RESTART_CONTAINER_SCRIPT_PATH: $RESTART_CONTAINER_SCRIPT_PATH"
# echo "UBUNTU_DEBIAN_SCRIPT_PATH: $UBUNTU_DEBIAN_SCRIPT_PATH"
# echo "UBUNTU_DEBIAN_ARM64_SCRIPT_PATH: $UBUNTU_DEBIAN_ARM64_SCRIPT_PATH"
# echo "UNINSTALL_SCRIPT_PATH: $UNINSTALL_SCRIPT_PATH"
# echo "UNINSTALL_LNMP_SCRIPT_PATH: $UNINSTALL_LNMP_SCRIPT_PATH"
# echo "UPDATE_SCRIPT_PATH: $UPDATE_SCRIPT_PATH"
