#!/bin/sh

cd $(dirname $0)

no_cache="$1"

if [[ "$no_cache" == '--no-cache' || ! -d 'Burrow' ]]; then
  rm -fr Burrow
  rm -fr tmp
  git clone https://github.com/linkedin/Burrow.git
fi

./create_burrow_fixes.sh \
&& cp -rfv docker-config/* Burrow/docker-config \
&& docker build $no_cache -t="streamworks/burrow" Burrow/
