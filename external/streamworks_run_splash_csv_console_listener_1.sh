#!/bin/sh

cd $(dirname $0)

java -cp .:target/MessageReceiver-1.0-SNAPSHOT.jar \
com.cleverfishsoftware.estreaming.kafka.consumer.RunKafkaConsumer \
localhost:9092 \
splash_csv_console_listener_1 \
consumer-1 splash_csv \
0
