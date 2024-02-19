#!bash/bin/

# 定义倒计�?
function countdown {
    local seconds=$1
    
    while [ $seconds -gt 0 ]; do
        echo -e "倒计�? $seconds 秒后开始安�?
        sleep 1
        ((seconds--))
    done
}

sudo apt-get update

countdown 3

sudo apt-get install \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
"deb [arch=arm64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
stable"
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

countdown 3

systemctl start docker
systemctl enable docker

countdown 3

# Docker-compose
curl -fsSL https://get.docker.com | bash -s docker

countdown 3

curl -L "https://github.com/docker/compose/releases/download/v2.19.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

countdown 3

chmod +x /usr/local/bin/docker-compose
