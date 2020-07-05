#!/bin/bash

# rsync -r --delete-after --quiet $TRAVIS_BUILD_DIR/<dir> $USER@$HOST:$DEPLOY_DIR
rsync --delete --exclude={.env.local,var/,public/pdf/} -Craqe  ssh $(pwd)/ ${PROD_USER}@${PROD_HOST}:${PROD_PATH}
ssh ${PROD_USER}@${PROD_HOST} make --directory=${PROD_PATH} deploy

