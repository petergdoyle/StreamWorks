#!/bin/sh

no_cache="$1"

if [ ! -d 'burrow' ]; then
  git clone https://github.com/linkedin/Burrow.git
fi

cp -rfv docker-config Burrow/docker-config \
&& cp -fv Dockerfile Burrow/Dockerfile \
&& docker build $no_cache -t="streamworks/burrow" Burrow/
