#!/bin/sh

cd $(dirname $0)

echo "removing burrow-stats..."; rm -fr burrow-stats/ && \
echo "cloning burrow-stats..."; git clone https://github.com/tulios/burrow-stats && \
echo "building burrow-stats..."; cp npm_clean_and_build.sh burrow-stats/ && \
burrow-stats/npm_clean_and_build.sh
