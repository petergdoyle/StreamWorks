#!/bin/sh

clean=$1

if [ "$clean" == '--clean' ]; then
  no_cache='--nocache'
fi

# clone the estreamig repo and modify some configs
external/estreaming_build.sh $no_cache

# build the two base project images
external/estreaming/docker/base/docker_build.sh $no_cache
external/estreaming/docker/jdk8/docker_build.sh $no_cache

# build the kafka docker image
external/estreaming/kafka/singlenode/streamworks_kafka_docker_build.sh $no_cache

# build the mongodb server
external/estreaming/mongo/docker_build.sh $no_cache

# build the burrow docker image
burrow/docker_build.sh $no_cache

# build the burrow-stats docker image
burrow-stats/docker_build.sh $no_cache

# build the couchbase server
couchbase/server/docker_build.sh $no_cache

# build the couchbase kafka loader program
if [[ "$clean" == '--clean' || ! -f 'couchbase/CouchbaseKafkaLoader/target/CouchbaseKafkaLoader-1.0-SNAPSHOT.jar' ]]; then
  mvn clean install -f couchbase/CouchbaseKafkaLoader/pom.xml
fi

# build the message sender application
if [[ "$clean" == '--clean' || ! -f 'external/estreaming/message-sender/MessageSender/target/MessageSender-1.0-SNAPSHOT.jar' ]]; then
  mvn clean install -f external/estreaming/message-sender/MessageSender/pom.xml
fi

# build the message receiver application
if [[ "$clean" == '--clean' || ! -f 'external/estreaming/message-receiver/MessageReceiver/target/MessageReceiver-1.0-SNAPSHOT.jar' ]]; then
  mvn clean install -f external/estreaming/message-receiver/MessageReceiver/pom.xml
fi
