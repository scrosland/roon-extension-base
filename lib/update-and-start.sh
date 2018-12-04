#!/bin/sh -e
set -x

npm update -g
cd $DATA/$EXTENSION
git pull
npm install --unsafe-perms --build-from-source

# start crond for check-for-updates.sh
mkdir -p $DATA/logs
crond -b -l 2

node $DATA/$EXTENSION
