#!/bin/bash

# enter script pwd
cd "$(dirname "${BASH_SOURCE[0]}")"

# script working path
SCRIPT_DIR="/DockerLNMP"

ADD_SITE_SCRIPT_PATH="$SCRIPT_DIR/commands/website/add_site.sh"
ARM64_SCRIPT_PATH="$SCRIPT_DIR/docker/arm64.sh"
CENTOS_SCRIPT_PATH="$SCRIPT_DIR/docker/centos.sh"
CHECK_NGINX_CONF_SCRIPT_PATH="$SCRIPT_DIR/commands/nginx/check_nginx_conf.sh"
CHECK_PHP_INSTALLED_EXTENSIONS_SCRIPT_PATH="$SCRIPT_DIR/commands/php/check_php_Installed_extensions.sh"
CHECK_PHP_DISABLE_FUNCTIONS_SCRIPT_PATH="$SCRIPT_DIR/commands/php/check_php_disable_functions.sh"
CHECK_PHP_ENTERED_EXTENSIONS_SCRIPT_PATH="$SCRIPT_DIR/commands/php/check_php_entered_extensions.sh"
COMMAND_SCRIPT_PATH="$SCRIPT_DIR/lnmp/command.sh"
COMPOSE_SCRIPT_PATH="$SCRIPT_DIR/docker/compose.sh"
CONFIG_SCRIPT_PATH="$SCRIPT_DIR/config.sh"
CONTAINERS_SERVICE_MENU_SCRIPT_PATH="$SCRIPT_DIR/menulist/containers_service_menu.sh"
DDSYSTEM_SCRIPT_PATH="$SCRIPT_DIR/docker/ddsystem.sh"
DOCKER_SCRIPT_PATH="$SCRIPT_DIR/docker/docker.sh"
GD_LIB_SCRIPT_PATH="$SCRIPT_DIR/lnmp/build/config/php/lib/gd_lib.sh"
GET_LNMP_SCRIPT_PATH="$SCRIPT_DIR/lnmp/get_lnmp.sh"
INSTALL_SCRIPT_PATH="$SCRIPT_DIR/install.sh"
INSTALL_LNMP_SCRIPT_PATH="$SCRIPT_DIR/lnmp/install_lnmp.sh"
INSTALL_PHP_EXTENSIONS_SCRIPT_PATH="$SCRIPT_DIR/commands/php/install_php_extensions.sh"
INSTALL_PHP_MODULES_SCRIPT_PATH="$SCRIPT_DIR/lnmp/build/config/php/lib/extension/install_php_modules.sh"
LNMP_MENU_SCRIPT_PATH="$SCRIPT_DIR/menulist/lnmp_menu.sh"
MENU_SCRIPT_PATH="$SCRIPT_DIR/menu.sh"
MENU_TEMPLATE_SCRIPT_PATH="$SCRIPT_DIR/menu_template.sh"
MYSQL_SERVER_SCRIPT_PATH="$SCRIPT_DIR/menulist/mysql_server.sh"
NGINX_SERVER_SCRIPT_PATH="$SCRIPT_DIR/menulist/nginx_server.sh"
PHP_SERVER_SCRIPT_PATH="$SCRIPT_DIR/menulist/php_server.sh"
PHPMYADMIN_SERVER_SCRIPT_PATH="$SCRIPT_DIR/menulist/phpmyadmin_server.sh"
RECOVER_OVERCOMMIT_MEMORY_SCRIPT_PATH="$SCRIPT_DIR/commands/redis/recover_overcommit_memory.sh"
REDIS_SERVER_SCRIPT_PATH="$SCRIPT_DIR/menulist/redis_server.sh"
RESTART_DATABASE_SCRIPT_PATH="$SCRIPT_DIR/commands/database/restart_database.sh"
RESTART_NGINX_SCRIPT_PATH="$SCRIPT_DIR/commands/nginx/restart_nginx.sh"
RESTART_PHP_SCRIPT_PATH="$SCRIPT_DIR/commands/php/restart_php.sh"
RESTART_PHPMYADMIN_SCRIPT_PATH="$SCRIPT_DIR/commands/phpmyadmin/restart_phpmyadmin.sh"
RESTART_REDIS_SCRIPT_PATH="$SCRIPT_DIR/commands/redis/restart_redis.sh"
RESTART_SERVER_SCRIPT_PATH="$SCRIPT_DIR/commands/restart_server.sh"
SET_OVERCOMMIT_MEMORY_SCRIPT_PATH="$SCRIPT_DIR/commands/redis/set_overcommit_memory.sh"
TEST_SCRIPT_PATH="$SCRIPT_DIR/test.check_comtainer.sh"
UBUNTU_DEBIAN_SCRIPT_PATH="$SCRIPT_DIR/docker/ubuntu_debian.sh"
UNINSTALL_SCRIPT_PATH="$SCRIPT_DIR/uninstall.sh"
UNINSTALL_LNMP_SCRIPT_PATH="$SCRIPT_DIR/lnmp/uninstall_lnmp.sh"
UPDATE_SCRIPT_PATH="$SCRIPT_DIR/update.sh"
WEBSITE_MENU_SCRIPT_PATH="$SCRIPT_DIR/menulist/website_menu.sh"

# other config...

# # path debug
# echo "ADD_SITE_SCRIPT_PATH: $ADD_SITE_SCRIPT_PATH"
# echo "ARM64_SCRIPT_PATH: $ARM64_SCRIPT_PATH"
# echo "CENTOS_SCRIPT_PATH: $CENTOS_SCRIPT_PATH"
# echo "CHECK_NGINX_CONF_SCRIPT_PATH: $CHECK_NGINX_CONF_SCRIPT_PATH"
# echo "CHECK_PHP_INSTALLED_EXTENSIONS_SCRIPT_PATH: $CHECK_PHP_INSTALLED_EXTENSIONS_SCRIPT_PATH"
# echo "CHECK_PHP_DISABLE_FUNCTIONS_SCRIPT_PATH: $CHECK_PHP_DISABLE_FUNCTIONS_SCRIPT_PATH"
# echo "CHECK_PHP_ENTERED_EXTENSIONS_SCRIPT_PATH: $CHECK_PHP_ENTERED_EXTENSIONS_SCRIPT_PATH"
# echo "COMMAND_SCRIPT_PATH: $COMMAND_SCRIPT_PATH"
# echo "COMPOSE_SCRIPT_PATH: $COMPOSE_SCRIPT_PATH"
# echo "CONFIG_SCRIPT_PATH: $CONFIG_SCRIPT_PATH"
# echo "CONTAINERS_SERVICE_MENU_SCRIPT_PATH: $CONTAINERS_SERVICE_MENU_SCRIPT_PATH"
# echo "DDSYSTEM_SCRIPT_PATH: $DDSYSTEM_SCRIPT_PATH"
# echo "DOCKER_SCRIPT_PATH: $DOCKER_SCRIPT_PATH"
# echo "GD_LIB_SCRIPT_PATH: $GD_LIB_SCRIPT_PATH"
# echo "GET_LNMP_SCRIPT_PATH: $GET_LNMP_SCRIPT_PATH"
# echo "INSTALL_SCRIPT_PATH: $INSTALL_SCRIPT_PATH"
# echo "INSTALL_LNMP_SCRIPT_PATH: $INSTALL_LNMP_SCRIPT_PATH"
# echo "INSTALL_PHP_EXTENSIONS_SCRIPT_PATH: $INSTALL_PHP_EXTENSIONS_SCRIPT_PATH"
# echo "INSTALL_PHP_MODULES_SCRIPT_PATH: $INSTALL_PHP_MODULES_SCRIPT_PATH"
# echo "LNMP_MENU_SCRIPT_PATH: $LNMP_MENU_SCRIPT_PATH"
# echo "MENU_SCRIPT_PATH: $MENU_SCRIPT_PATH"
# echo "MENU_TEMPLATE_SCRIPT_PATH: $MENU_TEMPLATE_SCRIPT_PATH"
# echo "MYSQL_SERVER_SCRIPT_PATH: $MYSQL_SERVER_SCRIPT_PATH"
# echo "NGINX_SERVER_SCRIPT_PATH: $NGINX_SERVER_SCRIPT_PATH"
# echo "PHP_SERVER_SCRIPT_PATH: $PHP_SERVER_SCRIPT_PATH"
# echo "PHPMYADMIN_SERVER_SCRIPT_PATH: $PHPMYADMIN_SERVER_SCRIPT_PATH"
# echo "RECOVER_OVERCOMMIT_MEMORY_SCRIPT_PATH: $RECOVER_OVERCOMMIT_MEMORY_SCRIPT_PATH"
# echo "REDIS_SERVER_SCRIPT_PATH: $REDIS_SERVER_SCRIPT_PATH"
# echo "RESTART_DATABASE_SCRIPT_PATH: $RESTART_DATABASE_SCRIPT_PATH"
# echo "RESTART_NGINX_SCRIPT_PATH: $RESTART_NGINX_SCRIPT_PATH"
# echo "RESTART_PHP_SCRIPT_PATH: $RESTART_PHP_SCRIPT_PATH"
# echo "RESTART_PHPMYADMIN_SCRIPT_PATH: $RESTART_PHPMYADMIN_SCRIPT_PATH"
# echo "RESTART_REDIS_SCRIPT_PATH: $RESTART_REDIS_SCRIPT_PATH"
# echo "RESTART_SERVER_SCRIPT_PATH: $RESTART_SERVER_SCRIPT_PATH"
# echo "SET_OVERCOMMIT_MEMORY_SCRIPT_PATH: $SET_OVERCOMMIT_MEMORY_SCRIPT_PATH"
# echo "TEST_SCRIPT_PATH: $TEST_SCRIPT_PATH"
# echo "UBUNTU_DEBIAN_SCRIPT_PATH: $UBUNTU_DEBIAN_SCRIPT_PATH"
# echo "UNINSTALL_SCRIPT_PATH: $UNINSTALL_SCRIPT_PATH"
# echo "UNINSTALL_LNMP_SCRIPT_PATH: $UNINSTALL_LNMP_SCRIPT_PATH"
# echo "UPDATE_SCRIPT_PATH: $UPDATE_SCRIPT_PATH"
# echo "WEBSITE_MENU_SCRIPT_PATH: $WEBSITE_MENU_SCRIPT_PATH"
