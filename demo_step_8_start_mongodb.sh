#!/bin/sh

container_name='streamworks_mongodb_server'

container_built=$(docker ps -a|grep $container_name |awk 'NF>1{print $NF}')
if [ ! "$container_built" == $container_name ]; then
  echo "run container $container_name..."
  external/estreaming/mongo/docker_run_mongodb_server_native.sh
else
  container_running=$(docker ps |grep $container_name |awk 'NF>1{print $NF}')
  if [ ! "$container_running" == $container_name ]; then
    echo "starting container $container_name..."
    docker start $container_name
  fi
fi
