#!/bin/sh

if [ ! -d 'mongo-hadoop' ]; then
  git clone https://github.com/mongodb/mongo-hadoop.git
fi

if [ ! -f 'mongo-hadoop-spark/target/lib/mongo-hadoop-core-1.5.1.jar' ]; then
  mvn clean install -f mongo-hadoop-spark/pom.xml
fi

docker build -t="streamworks/spark" .
