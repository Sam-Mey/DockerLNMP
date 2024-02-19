#!/bin/bash

# 定义倒计时
function countdown {
    local seconds=$1
    
    while [ $seconds -gt 0 ]; do
        echo_color "green" "倒计时: $seconds 秒后开始安装"
        sleep 1
        ((seconds--))
    done
}

yum install -y yum-utils

countdown 3

yum-config-manager \
--add-repo \
https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io -y

countdown 3

systemctl start docker
systemctl enable docker

# Docker-compose
countdown 3

curl -fsSL https://get.docker.com | bash -s docker

countdown 3

curl -L "https://github.com/docker/compose/releases/download/v2.19.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

countdown 3

chmod +x /usr/local/bin/docker-compose
