#!/bin/bash

clear

# Go to the directory where the script is located
cd "$(dirname "$0")"

# Include configuration
. /DockerLNMP/config.sh

# Define colors and styles using tput
BOLD=$(tput bold)         # 粗体
DIM=$(tput dim)           # 细体
GRAY=$(tput setaf 0)      # 灰色
RED=$(tput setaf 1)       # 红色
GREEN=$(tput setaf 2)     # 绿色
YELLOW=$(tput setaf 3)    # 黄色
BLUE=$(tput setaf 4)      # 蓝色
PURPLE=$(tput setaf 5)    # 紫色
CYAN=$(tput setaf 6)      # 青色
WHITE=$(tput setaf 7)     # 白色

UNDERLINE=$(tput smul): # 下划线
BLINK=$(tput blink):    # 闪烁
REVERSE=$(tput rev):    # 反显

RESET=$(tput sgr0)        # 重置样式

# Define menu options
options=(
    "${BOLD}${BLUE}  ${RESET}\n"
    
    "${BOLD}${RED}  ${RESET}"
    "${BOLD}${GREEN}  ${RESET}"
    "${BOLD}${GRAY}  ${RESET}"
)

# Show menu
function show_menu() {
    echo -e "${BOLD}${BLUE}———————————————————————————————— XX —————————————————————————————————— ${RESET}\n"
    for i in "${!options[@]}"; do
        if [[ $i -eq $(( ${#options[@]} - 1 )) ]]; then
            echo -e "${BOLD}${WHITE}b. ${options[$i]}${RESET}"  # b back
        else
            echo -e "${BOLD}${BLUE}$((i+1)). ${options[$i]}${RESET}"
        fi
    done
}

# Handle user choice
function menu_options() {
    read -p "${BOLD}${BLUE} 请输入选项编号:${RESET}" choice
    echo "DEBUG: User input is $choice"
    case $choice in
        1)
            clear
            echo -e "${BOLD}${YELLOW} XXX ${RESET}"
            "$XXXXXXX"
        ;;
        2)
            clear
            echo -e "${BOLD}${YELLOW} XXX ${RESET}"
            "$XXXXXX"
        ;;
        3)
            clear
            echo -e "${BOLD}${YELLOW} XXX ${RESET}"
            "$XXXXXXX"
        ;;
        4)
            clear
            echo -e "${BOLD}${YELLOW} XXX ${RESET}"
            "$XXXXXX"
        ;;
        B|b)
            clear
            echo "${BOLD}${WHITE} 返回上一级 ${RESET}"
            exit 0
        ;;
        *)
            clear
            echo -e "${BOLD}${RED} 无效选项，请重新选择 ${RESET}"
        ;;
    esac
}

while true; do
    show_menu
    menu_options
    if [[ $choice == "b" || $choice == "B" ]]; then
        break
    fi
done
