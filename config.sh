#!/bin/bash

# enter script pwd
cd "$(dirname "${BASH_SOURCE[0]}")"

# script working path
SCRIPT_DIR="/DockerLNMP"

ACME_SCRIPT_PATH="$SCRIPT_DIR/commands/acme/acme.sh"
ACME_CENTOS_SCRIPT_PATH="$SCRIPT_DIR/commands/acme/acme_centos.sh"
ACME_UBUNTU_DEBIAN_SCRIPT_PATH="$SCRIPT_DIR/commands/acme/acme_ubuntu_debian.sh"
ADD_SITE_SCRIPT_PATH="$SCRIPT_DIR/commands/website/add_site.sh"
ARM64_SCRIPT_PATH="$SCRIPT_DIR/docker/arm64.sh"
CENTOS_SCRIPT_PATH="$SCRIPT_DIR/docker/centos.sh"
CHECK_NGINX_CONF_SCRIPT_PATH="$SCRIPT_DIR/commands/nginx/check_nginx_conf.sh"
CHECK_PHP_INSTALLED_EXTENSIONS_SCRIPT_PATH="$SCRIPT_DIR/commands/php/check_php_Installed_extensions.sh"
CHECK_PHP_DISABLE_FUNCTIONS_SCRIPT_PATH="$SCRIPT_DIR/commands/php/check_php_disable_functions.sh"
CHECK_PHP_ENTERED_EXTENSIONS_SCRIPT_PATH="$SCRIPT_DIR/commands/php/check_php_entered_extensions.sh"
COMMAND_SCRIPT_PATH="$SCRIPT_DIR/commands/command.sh"
COMPOSE_SCRIPT_PATH="$SCRIPT_DIR/docker/compose.sh"
CONFIG_SCRIPT_PATH="$SCRIPT_DIR/config.sh"
CONTAINERS_LOGS_SCRIPT_PATH="$SCRIPT_DIR/commands/containers_logs.sh"
CONTAINERS_SERVER_LIST_SCRIPT_PATH="$SCRIPT_DIR/menulist/containers_server_list.sh"
DDSYSTEM_SCRIPT_PATH="$SCRIPT_DIR/docker/ddsystem.sh"
DOCKER_SCRIPT_PATH="$SCRIPT_DIR/docker/docker.sh"
GD_LIB_SCRIPT_PATH="$SCRIPT_DIR/lnmp/build/config/php/lib/gd_lib.sh"
GET_LNMP_SCRIPT_PATH="$SCRIPT_DIR/commands/get_lnmp.sh"
INSTALL_SCRIPT_PATH="$SCRIPT_DIR/install.sh"
INSTALL_LNMP_SCRIPT_PATH="$SCRIPT_DIR/commands/install_lnmp.sh"
INSTALL_PHP_EXTENSIONS_SCRIPT_PATH="$SCRIPT_DIR/commands/php/install_php_extensions.sh"
INSTALL_PHP_MODULES_SCRIPT_PATH="$SCRIPT_DIR/lnmp/build/config/php/lib/extension/install_php_modules.sh"
LNMP_MENU_SCRIPT_PATH="$SCRIPT_DIR/menulist/lnmp_menu.sh"
MENU_SCRIPT_PATH="$SCRIPT_DIR/menu.sh"
MYSQL_MENU_LIST_SCRIPT_PATH="$SCRIPT_DIR/menulist/mysql_menu_list.sh"
NGINX_MENU_LIST_SCRIPT_PATH="$SCRIPT_DIR/menulist/nginx_menu_list.sh"
PHP_MENU_LIST_SCRIPT_PATH="$SCRIPT_DIR/menulist/php_menu_list.sh"
PHPMYADMIN_MENU_LIST_SCRIPT_PATH="$SCRIPT_DIR/menulist/phpmyadmin_menu_list.sh"
RECOVER_OVERCOMMIT_MEMORY_SCRIPT_PATH="$SCRIPT_DIR/commands/redis/recover_overcommit_memory.sh"
REDIS_MENU_LIST_SCRIPT_PATH="$SCRIPT_DIR/menulist/redis_menu_list.sh"
RESTART_ALLCONTIANERS_SERVER_SCRIPT_PATH="$SCRIPT_DIR/commands/restart_allcontianers_server.sh"
RESTART_DATABASE_SCRIPT_PATH="$SCRIPT_DIR/commands/database/restart_database.sh"
RESTART_NGINX_SCRIPT_PATH="$SCRIPT_DIR/commands/nginx/restart_nginx.sh"
RESTART_PHP_SCRIPT_PATH="$SCRIPT_DIR/commands/php/restart_php.sh"
RESTART_PHPMYADMIN_SCRIPT_PATH="$SCRIPT_DIR/commands/phpmyadmin/restart_phpmyadmin.sh"
RESTART_REDIS_SCRIPT_PATH="$SCRIPT_DIR/commands/redis/restart_redis.sh"
SET_OVERCOMMIT_MEMORY_SCRIPT_PATH="$SCRIPT_DIR/commands/redis/set_overcommit_memory.sh"
TEMPLATE_SCRIPT_PATH="$SCRIPT_DIR/template.sh"
TEST_SCRIPT_PATH="$SCRIPT_DIR/test.sh"
UBUNTU_DEBIAN_SCRIPT_PATH="$SCRIPT_DIR/docker/ubuntu_debian.sh"
UNINSTALL_SCRIPT_PATH="$SCRIPT_DIR/commands/uninstall.sh"
UNINSTALL_LNMP_SCRIPT_PATH="$SCRIPT_DIR/commands/uninstall_lnmp.sh"
UPDATE_SCRIPT_PATH="$SCRIPT_DIR/commands/update.sh"
WEBSITE_MENU_SCRIPT_PATH="$SCRIPT_DIR/menulist/website_menu.sh"

# other config...

# # path debug
# echo "ACME_SCRIPT_PATH: $ACME_SCRIPT_PATH"
# echo "ACME_CENTOS_SCRIPT_PATH: $ACME_CENTOS_SCRIPT_PATH"
# echo "ACME_UBUNTU_DEBIAN_SCRIPT_PATH: $ACME_UBUNTU_DEBIAN_SCRIPT_PATH"
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
# echo "CONTAINERS_LOGS_SCRIPT_PATH: $CONTAINERS_LOGS_SCRIPT_PATH"
# echo "CONTAINERS_SERVER_LIST_SCRIPT_PATH: $CONTAINERS_SERVER_LIST_SCRIPT_PATH"
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
# echo "MYSQL_MENU_LIST_SCRIPT_PATH: $MYSQL_MENU_LIST_SCRIPT_PATH"
# echo "NGINX_MENU_LIST_SCRIPT_PATH: $NGINX_MENU_LIST_SCRIPT_PATH"
# echo "PHP_MENU_LIST_SCRIPT_PATH: $PHP_MENU_LIST_SCRIPT_PATH"
# echo "PHPMYADMIN_MENU_LIST_SCRIPT_PATH: $PHPMYADMIN_MENU_LIST_SCRIPT_PATH"
# echo "RECOVER_OVERCOMMIT_MEMORY_SCRIPT_PATH: $RECOVER_OVERCOMMIT_MEMORY_SCRIPT_PATH"
# echo "REDIS_MENU_LIST_SCRIPT_PATH: $REDIS_MENU_LIST_SCRIPT_PATH"
# echo "RESTART_ALLCONTIANERS_SERVER_SCRIPT_PATH: $RESTART_ALLCONTIANERS_SERVER_SCRIPT_PATH"
# echo "RESTART_DATABASE_SCRIPT_PATH: $RESTART_DATABASE_SCRIPT_PATH"
# echo "RESTART_NGINX_SCRIPT_PATH: $RESTART_NGINX_SCRIPT_PATH"
# echo "RESTART_PHP_SCRIPT_PATH: $RESTART_PHP_SCRIPT_PATH"
# echo "RESTART_PHPMYADMIN_SCRIPT_PATH: $RESTART_PHPMYADMIN_SCRIPT_PATH"
# echo "RESTART_REDIS_SCRIPT_PATH: $RESTART_REDIS_SCRIPT_PATH"
# echo "SET_OVERCOMMIT_MEMORY_SCRIPT_PATH: $SET_OVERCOMMIT_MEMORY_SCRIPT_PATH"
# echo "TEMPLATE_SCRIPT_PATH: $TEMPLATE_SCRIPT_PATH"
# echo "TEST_SCRIPT_PATH: $TEST_SCRIPT_PATH"
# echo "UBUNTU_DEBIAN_SCRIPT_PATH: $UBUNTU_DEBIAN_SCRIPT_PATH"
# echo "UNINSTALL_SCRIPT_PATH: $UNINSTALL_SCRIPT_PATH"
# echo "UNINSTALL_LNMP_SCRIPT_PATH: $UNINSTALL_LNMP_SCRIPT_PATH"
# echo "UPDATE_SCRIPT_PATH: $UPDATE_SCRIPT_PATH"
# echo "WEBSITE_MENU_SCRIPT_PATH: $WEBSITE_MENU_SCRIPT_PATH"
