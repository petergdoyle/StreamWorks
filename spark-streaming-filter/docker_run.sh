#!/bin/sh

cd $(dirname $0)

image_name='streamworks/spark'
container_name='streamworks_spark_streaming_mongo_filter'
start_container() {

  cmd_bash='/bin/bash'
  cmd_spark_submit='./spark_submit_pyspark_mongo.sh kafka_source_mongo_sink_pymongo_filtered.py'

  docker run -d -ti \
  -v $PWD/mongo-hadoop-builder/target/lib:/jarlib \
  -v $PWD/scripts:/scripts \
  --net host \
  --name $container_name \
  $image_name \
  $cmd_spark_submit
}

start_container
