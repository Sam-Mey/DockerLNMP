#!/bash/bin

# Define countdown
function countdown {
    local seconds=$1
    
    while [ $seconds -gt 0 ]; do
        echo -e "倒计时 $seconds 秒后开始安"
        sleep 1
        ((seconds--))
    done
}

sudo apt-get update
countdown 3

sudo apt-get install apt-transport-https \
ca-certificates \
curl \
gnupg lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
countdown 3

systemctl start docker
systemctl enable docker

# docker-compose
curl -fsSL https://get.docker.com | bash -s docker
countdown 3

curl -L "https://github.com/docker/compose/releases/download/1.26.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
countdown 3

chmod +x /usr/local/bin/docker-compose
