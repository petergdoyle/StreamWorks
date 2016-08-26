#!/bin/sh

start_container() {

  container_name=$1
  start_cmd=$2

  container_built=$(docker ps -a|grep $container_name |awk 'NF>1{print $NF}')
  if [ ! "$container_built" == $container_name ]; then
    echo "run container $container_name..."
    eval "$start_cmd"
    sleep 3
  else
    container_running=$(docker ps |grep $container_name |awk 'NF>1{print $NF}')
    if [ ! "$container_running" == $container_name ]; then
      echo "starting container $container_name..."
      docker start $container_name
    else
      echo "container $container_name already started. nothing to do..."
    fi
  fi

}
