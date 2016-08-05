#!/bin/sh

container_name='streamworks_kafka_burrow'

container_built=$(docker ps -a|grep '/go/bin/burrow' |awk 'NF>1{print $NF}')
if [ ! "$container_built" == $container_name ]; then
  echo "run container $container_name..."
  burrow/docker_run.sh
else
  container_running=$(docker ps |grep '/go/bin/burrow' |awk 'NF>1{print $NF}')
  if [ ! "$container_running" == $container_name ]; then
    echo "starting container $container_name..."
    docker start $container_name
  else
    echo "nothing to do..."
  fi
fi
