#!/bin/sh
cd $(dirname $0)
. ./scripts/demo_scripts.sh

image_name='streamworks/kafka'
container_name='streamworks_kafka_zk'
start_cmd="docker run -d -ti \
  --name streamworks_kafka_zk \
  --net host \
  streamworks/kafka \
  bin/zookeeper-server-start.sh config/zookeeper.properties"

start_container $container_name $start_cmd


container_name='streamworks_kafka_broker'
start_cmd="docker run -d -ti \
  --name streamworks_kafka_broker \
  -v $PWD/external/estreaming/kafka/singlenode/shared:/shared  \
  --net host \
  streamworks/kafka \
  bin/kafka-server-start.sh config/server.properties"

start_container $container_name $start_cmd

docker logs -f $container_name
