#!/bin/sh

cd $(dirname $0)

java -Xms1G -Xmx1G -DLoadGenerator.KafkaMessageSenderBuilder.broker_url="localhost:9092" -DLoadGenerator.KafkaMessageSenderBuilder.topic_name="splash_csv" -DLoadGenerator.AirlineDataPayloadGeneratorBuilder.airlineDataFormatterType="com.cleverfishsoftware.loadgenerator.payload.air.AirlineDataFormatterCSV" -cp .:target/MessageSender-1.0-SNAPSHOT.jar com.cleverfishsoftware.loadgenerator.MessageSenderRunner com.cleverfishsoftware.loadgenerator.sender.kafka.KafkaMessageSenderBuilder com.cleverfishsoftware.loadgenerator.payload.air.AirlineDataPayloadGeneratorBuilder 4 0 0 2 n
