#!/bin/bash
# Deploy cablemess to the VPS as user apps (rootless Docker), beside Stoodiohub but separate from it.
set -euo pipefail
cd "$(dirname "$0")/.."
DIR=/srv/apps/cablemess
ssh apps-vps "mkdir -p $DIR/build $DIR/data"
rsync -rt --delete --exclude .git --exclude .env --exclude data ./ "apps-vps:$DIR/build/"
ssh apps-vps "cd $DIR/build && docker build -q -t cablemess:local . >/dev/null"
scp -q docker-compose.yml "apps-vps:$DIR/docker-compose.yml"
ssh apps-vps "test -f $DIR/.env" || { scp -q .env.example "apps-vps:$DIR/.env"; echo "Copied .env.example to $DIR/.env: fill it in, then run again."; exit 1; }
ssh apps-vps "cd $DIR && docker compose up -d --remove-orphans && docker image prune -f >/dev/null"
sleep 3; ssh apps-vps "docker logs --tail 5 cablemess"
