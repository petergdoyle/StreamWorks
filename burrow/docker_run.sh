#!/bin/sh
cd $(dirname $0)
rm -f tmp/*

cmd=$1
img_name='streamworks/burrow'
container_name='streamworks_kafka_burrow'
bash_cmd='/bin/bash'
burrow_cmd='/go/bin/burrow -config /etc/burrow/burrow.cfg'
volumes="-v $PWD/tmp:/var/tmp/burrow"

docker run -d -ti \
  --net host \
  $volumes \
  --name $container_name \
  $img_name \
  $burrow_cmd
