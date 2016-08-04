#!/bin/sh
cd $(dirname $0)

no_cache='--no-cache'

if [[ "$no_cache" == '--no-cache' || ! -d 'burrow-stats' ]]; then
  rm -fr burrow-stats
  git clone https://github.com/tulios/burrow-stats
fi

if [[ "$no_cache" == '--no-cache' || ! -f 'configs.json' ]]; then
  cp configs.streamworks.json configs.json
fi
cp -vf configs.json burrow-stats/configs.json

docker build $no_cache -t="streamworks/burrow-stats" burrow-stats/
