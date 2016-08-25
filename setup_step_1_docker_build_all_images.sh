#!/bin/sh

clean=$1

if [ "$clean" == '--clean' ]; then
  no_cache='--no-cache'
fi

if [ "$clean" == '--clean' ]; then
  . ./setup_step_0_clean_all.sh
fi


# clone the estreamig repo and modify some configs
external/estreaming_build.sh $no_cache
if [ $? -ne 0 ]; then
  echo -e "\e[7;107;91mThis step did not build. Please check console for errors.\e[0m"
  exit 1
fi

build_image() {
  img_name=$1
  build_script=$2
  eval "docker images |grep $img_name" > /dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo -e "\e[7;44;96mBuilding image $img_name...\e[0m"
    eval "$build_script"
    if [ $? -ne 0 ]; then
      echo -e "\e[7;107;91mThis image $img_name did not build properly. Please check console for errors.\e[0m"
      exit 1
    fi
  else
    echo -e "\e[7;44;96mImage $img_name already built. Skipping.\e[0m"
  fi
}

# build the base images
build_image 'streamworks/base' "external/estreaming/docker/base/docker_build.sh $no_cache"
build_image 'streamworks/basejdk' "external/estreaming/docker/jdk8/docker_build.sh $no_cache"
build_image 'streamworks/nodejs' "external/estreaming/docker/nodebase/docker_build.sh $no_cache"

# build the kafka docker image
build_image 'streamworks/kafka' "external/estreaming/kafka/singlenode/streamworks_kafka_docker_build.sh $no_cache"

# build the mongodb server
build_image 'streamworks/mongodb' "external/estreaming/mongo/docker_build.sh $no_cache"

# build the nodejs streaming api server
build_image 'streamworks/nodejs' "external/estreaming/nodejs/streamworks_nodejs_server_and_client_docker_build.sh $no_cache"

# build the burrow docker image
build_image 'streamworks/burrow' "burrow/docker_build.sh $no_cache"

# build the burrow-stats docker image
build_image 'streamworks/burrow-stats' "burrow-stats/docker_build.sh $no_cache"

# build the flume image
build_image 'streamworks/flume' "flume-hdfs-loader/docker_build.sh $no_cache"

# build the couchbase server
build_image 'streamworks/couchbase' "couchbase/server/docker_build.sh $no_cache"

# build the kafka python message converter
build_image 'streamworks/python' "python-message-converter/docker_build.sh $no_cache"

# build the pymongo spark-streaming filter image
echo -e "\e[7;44;96mSkipping image streamworks/hadoop...\e[0m"
#hadoop-singlenode-hdfs-cluster/docker_build.sh $no_cache

# build the pymongo spark-streaming filter image
build_image 'streamworks/spark' "spark-streaming-filter/docker_build.sh $no_cache"

# build the flume kafka hdfs loader image
build_image 'streamworks/flume' "flume-hdfs-loader/docker_build.sh $no_cache"

mvn_build() {
  artifact_id=$1
  jar_file=$2
  pom_file=$3
  if [[ "$clean" == '--clean' || ! -f "$jar_file" ]]; then
    echo -e "\e[7;44;96mBuilding $artifact_id...\e[0m"
    mvn clean install -f "$pom_file"
  else
    echo -e "\e[7;44;96m$artifact_id already built. Skipping.\e[0m"
  fi
}

# build the couchbase kafka loader program
mvn_build 'CouchbaseKafkaLoader' \
  'couchbase/CouchbaseKafkaLoader/target/CouchbaseKafkaLoader-1.0-SNAPSHOT.jar' \
  'couchbase/CouchbaseKafkaLoader/pom.xml'

# build the message sender app
mvn_build 'MessageSender' \
  'external/estreaming/message-sender/MessageSender/target/MessageSender-1.0-SNAPSHOT.jar' \
  'external/estreaming/message-sender/MessageSender/pom.xml'

# build the message receiver application
mvn_build 'MessageReceiver' \
  'external/estreaming/message-receiver/MessageReceiver/target/MessageReceiver-1.0-SNAPSHOT.jar' \
  'external/estreaming/message-receiver/MessageReceiver/pom.xml'

# display the build status
declare -a arr=('streamworks/base ' 'streamworks/spark' 'streamworks/python' \
'streamworks/flume' 'streamworks/burrow-stats' 'streamworks/burrow ' \
'streamworks/mongodb' 'streamworks/kafka' 'streamworks/nodejs' 'streamworks/basejdk')

for each in "${arr[@]}"
do
  if [ ! $(docker images |grep streamworks |grep "$each" |wc -l) == "1" ]; then
    echo -e "\e[7;107;91m$each image did not build. check output\e[0m"
  else
    echo -e "\e[7;40;92m$each image built sucesssfully\e[0m"
  fi
done
