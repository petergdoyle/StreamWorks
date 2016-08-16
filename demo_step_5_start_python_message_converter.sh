#!/bin/sh
container_name='streamworks_python_message_converter'

container_built=$(docker ps -a|grep $container_name |awk 'NF>1{print $NF}')
if [ ! "$container_built" == $container_name ]; then
  echo "run container $container_name..."
  python-message-converter/docker_run.sh
else
  container_running=$(docker ps |grep $container_name |awk 'NF>1{print $NF}')
  if [ ! "$container_running" == $container_name ]; then
    echo "starting container $container_name..."
    docker start $container_name
  else
    echo "nothing to do..."
  fi
fi
sleep 3
python-message-converter/docker_tailf_logs.sh
