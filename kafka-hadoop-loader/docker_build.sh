#!/bin/sh
cd $(dirname $0)

if [ ! -d 'kafka-hadoop-loader' ]; then
  git clone https://github.com/michal-harish/kafka-hadoop-loader.git
fi

if [ ! -d 'kafka-hadoop-loader/target' ]; then
  mvn clean install -f kafka-hadoop-loader/pom.xml
fi
