#!/bash/bin

echo_color "green" "安装Docker..."
curl -fsSL https://get.docker.com | bash -s docker
echo_color "green" "完成"

echo_color "green" "安装Docker-compose"
curl -L "https://github.com/docker/compose/releases/download/v2.19.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
echo_color "green" "安装完成"

echo_color "green" "赋予docker-compose执行权限"
chmod +x /usr/local/bin/docker-compose
echo_color "green" "完成"
