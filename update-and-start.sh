#!/bin/sh -e
set -x

npm update -g
cd $DATA/$EXTENSION
git pull
npm install --unsafe-perms --build-from-source

# start crond for check-for-updates.sh
nohup crond -l 2 -f >/dev/null 2>&1 &

node $DATA/$EXTENSION
