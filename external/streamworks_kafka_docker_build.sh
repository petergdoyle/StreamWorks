#!/bin/sh
cd $(dirname $0)


. ../../scripts/lib/docker_functions.sh

no_cache=$1

# specify connection properties
zk_host_port="localhost:2181"
sed -i "s/zookeeper.connect.*/zookeeper.connect=$zk_host_port/g" config/server.properties

# fix log retention at 1 hour
kafka_log_retention_hrs="1"
sed -i "s/log.retention.hours.*/log.retention.hours=$kafka_log_retention_hrs/g" config/server.properties

# fix log retention size at 25mb
kafka_log_retention_size_mb="25"
kafka_log_retention_size=$((1024*1024*$kafka_log_retention_size_mb))
sed -i "s/log.retention.bytes.*/log.retention.bytes=$kafka_log_retention_size/g" config/server.properties
sed -i "s/log.segment.bytes.*/log.segment.bytes=$kafka_log_retention_size/g" config/server.properties

img_name='streamworks/kafka'

docker_build $no_cache
