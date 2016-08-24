#!/bin/sh

clean=$1

if [ "$clean" == '--clean' ]; then
  no_cache='--no-cache'
fi

if [ "$clean" == '--clean' ]; then
  rm -fr external/estreaming
  rm -fr burrow-stats/burrow-stats/
  rm -fr burrow/Burrow/
fi


# clone the estreamig repo and modify some configs
external/estreaming_build.sh $no_cache

# build the two base project images
external/estreaming/docker/base/docker_build.sh $no_cache
external/estreaming/docker/jdk8/docker_build.sh $no_cache
external/estreaming/docker/nodebase/docker_build.sh $no_cache

# build the kafka docker image
external/estreaming/kafka/singlenode/streamworks_kafka_docker_build.sh $no_cache

# build the mongodb server
external/estreaming/mongo/docker_build.sh $no_cache

# build the nodejs streaming api server
external/estreaming/nodejs/streamworks_nodejs_server_and_client_docker_build.sh $no_cache

# build the burrow docker image
burrow/docker_build.sh $no_cache

# build the burrow-stats docker image
burrow-stats/docker_build.sh $no_cache

# build the flume image
flume-hdfs-loader/build.sh $no_cache

# build the couchbase server
couchbase/server/docker_build.sh $no_cache

# build the kafka python message converter
python-message-converter/docker_build.sh $no_cache

# build the pymongo spark-streaming filter image
#hadoop-singlenode-hdfs-cluster/docker_build.sh $no_cache

# build the pymongo spark-streaming filter image
spark-streaming-filter/docker_build.sh $no_cache

# build the flume kafka hdfs loader image
flume-hdfs-loader/docker_build.sh $no_cache

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

# display the status
declare -a arr=("/base " "basejdk" "spark" "hadoop" "python" "burrow " "burrow-stats" "mongodb" "couchbase" "flume")
for each in "${arr[@]}"
do
  if [ ! $(docker images |grep streamworks |grep "$each" |wc -l) == "1" ]; then
    echo -e "\e[7;107;91m$each image did not build. check output\e[0m"
  else
    echo -e "\e[7;40;92m$each image built sucesssfully\e[0m"
  fi
done
