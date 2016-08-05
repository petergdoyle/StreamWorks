#!/bin/sh

container_name='streamworks_couchbase'

container_built=$(docker ps -a|grep $container_name |awk 'NF>1{print $NF}')
if [ ! "$container_built" == $container_name ]; then
  couchbase/server/docker_run.sh
else
  container_running=$(docker ps |grep $container_name |awk 'NF>1{print $NF}')
  if [ ! "$container_running" == $container_name ]; then
    docker start $container_name
  fi
fi
