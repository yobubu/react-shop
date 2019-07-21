#!/bin/bash

set -e

SERVER=pozi@165.227.149.182
APP_DIR=/home/pozi/bgshop

set -x

yarn build
rsync -avzP build/ $SERVER:$APP_DIR
rsync -avzP package.json $SERVER:$APP_DIR
rsync -avzP yarn.lock $SERVER:$APP_DIR
ssh $SERVER "cd $APP_DIR && yarn"
ssh $SERVER "pm2 restart index"
rm -rf build
