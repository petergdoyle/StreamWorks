#!/bin/sh

# clone the estreamig repo and modify some configs
external/estreaming_build.sh

# build the two base project images
external/estreaming/docker/base/docker_build.sh
external/estreaming/docker/jdk8/docker_build.sh

# build the message sender application
mvn clean install -f external/estreaming/message-sender/MessageSender/pom.xml
# build the message receiver application
mvn clean install -f external/estreaming/message-receiver/MessageReceiver/pom.xml

# build the kafka docker image
external/estreaming/kafka/singlenode/streamworks_kafka_docker_build.sh

# build the burrow docker image
burrow/docker_build.sh

# build the burrow-stats docker image
burrow-stats/docker_build.sh
