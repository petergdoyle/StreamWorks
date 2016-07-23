#!/bin/sh

# clone the estreamig repo and modify some configs
external/estreaming_build.sh

# run the base docker image build
external/estreaming/message-sender/MessageSender/docker_build.sh
# run the base jdk image build
external/estreaming/docker/base/docker_build.sh
# build the message sender application and docker image
external/estreaming/kafka/docker_build.sh
# build the message receiver application
mvn clean install -f external/estreaming/message-sender/MessageSender/pom.xml

# build the burrow docker image
burrow/docker_build.sh

# build the burrow-stats docker image
burrow-stats/docker_build.sh
