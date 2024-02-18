#!/bin/bash

cd /

docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
echo "y" | docker rmi $(docker images -aq)
echo "y" | docker network prune



