#!/bin/bash
# Deploy cablemess to WOPR: send the code, build the image there, start the stack.
set -euo pipefail
cd "$(dirname "$0")/.."
DIR=/share/CACHEDEV2_DATA/DockerData/cablemess
DOCKER="DOCKER_CONFIG=$DIR/.docker /share/CACHEDEV2_DATA/.qpkg/container-station/bin/docker"
ssh wopr "mkdir -p $DIR/build $DIR/data"
rsync -rt --delete --exclude .git --exclude .env --exclude data ./ "wopr:$DIR/build/"
ssh wopr "cd $DIR/build && $DOCKER build -q -t cablemess:local . >/dev/null"
scp -q docker-compose.yml "wopr:$DIR/docker-compose.yml"
ssh wopr "test -f $DIR/.env" || { scp -q .env.example "wopr:$DIR/.env"; echo "Copied .env.example to $DIR/.env: fill it in, then run again."; exit 1; }
ssh wopr "cd $DIR && $DOCKER compose up -d --remove-orphans && $DOCKER image prune -f >/dev/null"
sleep 3; ssh wopr "$DOCKER logs --tail 5 cablemess"
