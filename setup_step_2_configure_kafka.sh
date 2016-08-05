#!/bin/sh

eval "docker images |grep 'streamworks/kafka'" > /dev/null 2>&1
if [ $? -eq 1 ]; then
  echo "No 'streamWorks/kafka' image appears to be built. 'setup_step_1_docker_build_all_images.sh' . Cannot continue"
  echo "The following Docker images were found:"
  echo "`docker images`"
  exit 1
fi

echo "starting kafka singlenode cluster..."
docker run -d -ti   --name streamworks_kafka_zk --net host streamworks/kafka bin/zookeeper-server-start.sh config/zookeeper.properties
echo "`docker ps -a| grep kafka_zk`"
sleep 3
docker run -d -ti   --name streamworks_kafka_broker -v $PWD/external/estreaming/kafka/singlenode/shared:/shared  --net host streamworks/kafka bin/kafka-server-start.sh config/server.properties
echo "`docker ps -a| grep kafka`"
sleep 3

echo "creating kafka topic 'splash_csv'..."
docker exec -ti streamworks_kafka_broker bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic splash_csv

echo "creating kafka topic 'splash_json'..."
docker exec -ti streamworks_kafka_broker bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic splash_json

echo "more docker kafka scripts are located under 'external/estreaming/kafka/singlenode'..."
ls -al external/estreaming/kafka/singlenode
