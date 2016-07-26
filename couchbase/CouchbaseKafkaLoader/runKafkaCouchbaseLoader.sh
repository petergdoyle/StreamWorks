#!/bin/sh
cd $(dirname $0)

java \
-cp .:target/CouchbaseKafkaLoader-1.0-SNAPSHOT.jar \
com.cleverfishsoftware.streaming.couchbase.kafkaloader.KafkaCouchbaseLoader
