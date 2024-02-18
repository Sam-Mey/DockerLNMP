#!/bin/bash

# set -x # 调试信息

clear

# 设置版本号
VERSION="v1.5.0"

# 打印当前工作目录
# echo "Current working directory: $(pwd)"

# 设置脚本所在目录为当前工作目录
cd "$(dirname "${BASH_SOURCE[0]}")" || exit

# 打印执行 cd 命令（改变当前工作目录）之后，输出改变后的当前工作目录
# echo "Current working directory after cd: $(pwd)"

# 引入配置
. /DockerLNMP/config.sh

# # 打印调试信息
# echo "SCRIPT_DIR: $SCRIPT_DIR"
# echo "MENU_SCRIPT_PATH: $MENU_SCRIPT_PATH"
# echo "WEBSITE_MENU_SCRIPT_PATH: $WEBSITE_MENU_SCRIPT_PATH"
# echo "ACME_SCRIPT_PATH: $ACME_SCRIPT_PATH"

# Define colors and styles using tput
BOLD=$(tput bold)
GRAY=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
PURPLE=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)

RESET=$(tput sgr0)

echo -e "\033[96m—————————————————————————— Docker LNMP 网站环境 $VERSION ————————————————————————————\033[0m"
echo -e "\033[96m	______ _____ _____  _   __ ___________       _      _   _ ___  _________ 	\033[0m"
echo -e "\033[96m	|  _  \  _  /  __ \| | / /|  ___| ___ \     | |    | \ | ||  \/  || ___ \	\033[0m"
echo -e "\033[96m	| | | | | | | /  \/| |/ / | |__ | |_/ /     | |    |  \| || .  . || |_/ /	\033[0m"
echo -e "\033[96m	| | | | | | | |    |    \ |  __||    /      | |    | .   || |\/| ||  __/ 	\033[0m"
echo -e "\033[96m	| |/ /\ \_/ / \__/\| |\  \| |___| |\ \      | |____| |\  || |  | || |    	\033[0m"
echo -e "\033[96m	|___/  \___/ \____/\_| \_/\____/\_| \_\     |_____/\_| \_/\_|  |_/\_|    	\033[0m"
echo -e "\033[96m                                                                               \033[0m"
echo -e "${BOLD}${YELLOW} 温馨提示：${RESET}\n"
echo -e "${BOLD}${YELLOW}       目前环境仅支持 Ubuntu Debian arm64 系统; ${RESET}"
echo -e "${BOLD}${YELLOW}       amd 及其他系待测试... ${RESET}"
echo -e "${BOLD}${YELLOW}       安装完成后，再次使用命令行键入 'dlnmp' 调出菜单。 ${RESET}\n"

# Define menu options
options=(
    "${BOLD}${BLUE} Docker LNMP >> ${RESET}\n"
    
    "${BOLD}${RED} 退出脚本 ${RESET}"
    "${BOLD}${GREEN} 更新脚本 ${RESET}"
    "${BOLD}${GRAY} 卸载脚本 ${RESET}"
)

# Show menu
function show_menu() {
    echo -e "${BOLD}${BLUE}————————————————————————————————— 主菜单 $VERSION ———————————————————————————————————${RESET}\n"
    for i in "${!options[@]}"; do
        if [[ $i -eq $(( ${#options[@]} - 3 )) ]]; then
            echo -e "${BOLD}${RED}q. ${options[$i]}${RESET}"  # q 退出选项
            elif [[ $i -eq $(( ${#options[@]} -2 )) ]]; then
            echo -e "${BOLD}${GREEN}u. ${options[$i]}${RESET}"  # u 更新选项
            elif [[ $i -eq $(( ${#options[@]} -1 )) ]]; then
            echo -e "${BOLD}${GRAY}r. ${options[$i]}${RESET}\n"  # r 卸载选项
        else
            echo -e "${BOLD}${BLUE}$((i+1)). ${options[$i]}${RESET}"
        fi
    done
}

# Handle user choice
function menu_options() {
    read -p "${BOLD}${BLUE} 请输入选项编号:${RESET}" choice
    echo "DEBUG: User input is $choice"  # 添加调试信息
    case $choice in
        1)
            clear
            echo -e "${BOLD}${YELLOW} Docker LNMP 选项 ${RESET}"
            "$LNMP_MENU_SCRIPT_PATH"
        ;;
        2)
            clear
            echo -e "${BOLD}${YELLOW} WebSite ${RESET}"
            "$XXXXXX"
        ;;
        Q|q)
            clear
            echo "${BOLD}${RED} 谢谢使用，再见！ ${RESET}"
            exit 0  # 退出脚本
        ;;
        U|u)
            clear
            echo -e "${BOLD}${YELLOW} 正在拉取 GitHub 仓库的最新提交... ${RESET}"
            "$UPDATE_SCRIPT_PATH"
        ;;
        R|r)
            clear
            # 打印提示消息，并设置默认值为N
            read -p "$(echo -e "${BOLD}${YELLOW}是否确认卸载脚本? (默认为N) | [N/y]: ${RESET}")" -i "N" answer
            # 根据用户的选择执行相应操作
            if [ "${answer,,}" = "y" ]; then
                echo -e "${BOLD}${RED} 正在卸载脚本... ${RESET}"
                # 执行卸载 脚本 的操作，可以调用相应的脚本或命令
                "$UNINSTALL_SCRIPT_PATH"
                exit 0  # 退出脚本
            else
                echo -e "${BOLD}${YELLOW} 脚本卸载已取消. ${RESET}"
            fi
        ;;
        *)
            clear
            echo -e "${BOLD}${RED} 无效选项，请重新选择 ${RESET}"
        ;;
    esac
}

# 主循环
while true; do
    show_menu
    menu_options
done

