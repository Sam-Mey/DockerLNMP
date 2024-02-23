#!/bin/bash

BOLD=$(tput bold) 
GREEN=$(tput setaf 2) 
RESET=$(tput sgr0)

echo -e "${BOLD}${GREEN}正在安装必要的依赖和获取证书...${RESET}"
apt-get install -y socat
curl https://get.acme.sh | sh
ln -s /root/.acme.sh/acme.sh /usr/local/bin/acme.sh

# 用户注册
echo -e "${BOLD}${GREEN}请输入您的邮箱地址：${RESET}"
read email_address
acme.sh --register-account -m "$email_address"

# 开始申请证书
echo -e "${BOLD}${GREEN}请输入您的域名：${RESET}"
read your_domain
acme.sh --issue -d "$your_domain" --standalone -k ec-256

cd root && mkdir certs

# 安装证书到路径（默认 root 目录）
acme.sh --installcert -d "$your_domain" --ecc --key-file /root/certs/private.key --fullchain-file /root/certs/certificate.crt
echo -e "${BOLD}${GREEN}证书申请成功，并已安装到 root/certs 目录下；您可以手动更改使用位置！${RESET}"

cp -r certs /DockerLNMP/www/server/nginx
