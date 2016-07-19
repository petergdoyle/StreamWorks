#!/bin/sh
. ../../scripts/lib/docker_functions.sh

docker_destroy streamworks_kafka_broker
docker_destroy streamworks_kafka_zk
