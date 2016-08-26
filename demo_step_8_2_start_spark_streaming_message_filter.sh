#!/bin/sh
cd $(dirname $0)
. ./scripts/demo_scripts.sh

image_name='streamworks/spark'
container_name='streamworks_spark_streaming_mongo_filter'
start_cmd="spark-streaming-filter/docker_run.sh"

start_container $container_name $start_cmd

docker logs -f $container_name
