#!/bin/bash

# root user
root_need(){
    if [[ $EUID -ne 0 ]]; then
        echo -e "\033[31m 错误:该脚本必须以 root 身份运行! \033[0m" 1>&2
        exit 1
    fi
}

# Call functions
root_need

cd /

# Clone the repository
git clone https://github.com/Sam-Mey/DockerLNMP.git

# Find all .sh files and chmod +x
find /DockerLNMP -name "*.sh" -exec chmod +x {} \;

# Create a symbolic link for menu.sh
ln -s "/DockerLNMP/menu.sh" "/usr/local/bin/lnmp"

# Check if it's not being run for removal
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    rm -rf /root/install.sh
fi

# Run 'lnmp' command (make sure 'et' is set up before this point)
lnmp
