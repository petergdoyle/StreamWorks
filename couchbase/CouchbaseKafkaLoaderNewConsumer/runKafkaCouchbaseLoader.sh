#!/bin/sh
cd $(dirname $0)

java \
-cp .:target/CouchbaseKafkaLoaderNewConsumer-1.0-SNAPSHOT.jar \
com.cleverfishsoftware.streaming.couchbase.kafkaloader.KafkaCouchbaseLoader
