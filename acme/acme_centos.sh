#!/bash/bin

echo_color "green" "正在安装必要的依赖和获取证书..."
yum install -y socat
curl https://get.acme.sh | sh
ln -s /root/.acme.sh/acme.sh /usr/local/bin/acme.sh

# 用户注册
echo_color "green" "请输入您的邮箱地址："
read email_address
acme.sh --register-account -m "$email_address"

# 开始申请证书
echo_color "green" "请输入您的域名："
read your_domain
acme.sh --issue -d "$your_domain" --standalone -k ec-256

cd root && mkdir certs

# 安装证书到路径
acme.sh --installcert -d "$your_domain" --ecc --key-file /root/certs/private.key --fullchain-file /root/certs/certificate.crt
echo_color "green" "证书申请成功，并已安装到 /root/certs 目录下；您可以手动更改使用位置！"

cp certs /DockerLNMP/www/server/nginx