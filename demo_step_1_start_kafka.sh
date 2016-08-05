#!/bin/sh

docker start streamworks_kafka_zk
sleep 2
docker start streamworks_kafka_broker
