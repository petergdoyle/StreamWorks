#!/bin/sh
cd $(dirname $0)

docker run \
  -d \
  --net host \
  -e PORT=8022 \
  -v $PWD/configs.json:/opt/burrow-stats/configs.json \
  --name streamworks_kafka_burrow_stats \
  streamworks/burrow-stats
