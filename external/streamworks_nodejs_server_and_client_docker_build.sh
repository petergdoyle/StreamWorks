#!/bin/sh
cd $(dirname $0)

. ../scripts/lib/docker_functions.sh

no_cache=$1

img_name='streamworks/nodejs'

cd streaming_api_client
status=$(git status --porcelain .)
if [[ "$status" != "" || ! -d "node_modules" ]]; then
  rm -fr node_modules
  npm install
fi
cd -

cd streaming_api_server
status=$(git status --porcelain .)
if [[ "$status" != "" || ! -d "node_modules" ]]; then
  rm -fr node_modules
  npm install
fi
cd -

docker_build $no_cache
