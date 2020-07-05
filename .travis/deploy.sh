#!/bin/bash

git config --global push.default matching
git remote add deploy ssh://git@$HOST:$PORT$DEPLOY_DIR
git push deploy master

# Skip this command if you don't need to execute any additional commands after deploying.
ssh $USER@$HOST -p $PORT <<EOF
  cd $DEPLOY_DIR
  make deploy
EOF

