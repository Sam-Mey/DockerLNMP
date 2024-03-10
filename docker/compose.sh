#!/bash/bin

# Define countdown
function countdown {
    local seconds=$1
    
    while [ $seconds -gt 0 ]; do
        echo -e "倒计时 $seconds 秒后开始"
        sleep 1
        ((seconds--))
    done
}

echo_color "green" "安装Docker..."
curl -fsSL https://get.docker.com | bash -s docker
echo_color "green" "完成"
countdown 5

echo_color "green" "安装Docker-compose"
curl -L "https://github.com/docker/compose/releases/download/v2.19.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
echo_color "green" "安装完成"
countdown 5

echo_color "green" "赋予docker-compose执行权限"
chmod +x /usr/local/bin/docker-compose
echo_color "green" "完成"
