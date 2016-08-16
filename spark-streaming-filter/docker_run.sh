#!/bin/sh


cd $(dirname $0)

docker run -d -ti \
-v $PWD/mongo-hadoop-builder/target/lib:/jarlib \
-v $PWD/scripts:/scripts \
--net host \
--name streamworks_spark_streaming_mongo_filter \
streamworks/spark \
/bin/bash
