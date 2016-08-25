#!/bin/sh

container_name='streamworks_kafka_zk'

container_built=$(docker ps -a|grep $container_name |awk 'NF>1{print $NF}')
if [ ! "$container_built" == $container_name ]; then
  echo "starting kafka singlenode cluster..."
  docker run -d -ti \
    --name streamworks_kafka_zk \
    --net host \
    streamworks/kafka \
    bin/zookeeper-server-start.sh config/zookeeper.properties
  sleep 3
else
  container_running=$(docker ps |grep $container_name |awk 'NF>1{print $NF}')
  if [ ! "$container_running" == $container_name ]; then
    echo "starting container $container_name..."
    docker start $container_name
  else
    echo "nothing to do..."
  fi
fi

container_name='streamworks_kafka_broker'
container_built=$(docker ps -a|grep $container_name |awk 'NF>1{print $NF}')
if [ ! "$container_built" == $container_name ]; then
  docker run -d -ti \
    --name streamworks_kafka_broker \
    -v $PWD/external/estreaming/kafka/singlenode/shared:/shared  \
    --net host \
    streamworks/kafka \
    bin/kafka-server-start.sh config/server.properties
  sleep 3
else
  container_running=$(docker ps |grep $container_name |awk 'NF>1{print $NF}')
  if [ ! "$container_running" == $container_name ]; then
    echo "starting container $container_name..."
    docker start $container_name
  else
    echo "nothing to do..."
  fi
fi

docker logs -f $container_name
