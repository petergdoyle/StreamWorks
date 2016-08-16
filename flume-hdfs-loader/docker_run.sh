#!/bin/sh

start_flume='flume_start.sh'
bash_cmd='/bin/bash'
cmd=$bash_cmd
mode='-d'
networking='--net host'

docker run $mode -ti \
$networking \
-v $PWD:/docker \
--name streamworks_flume_hdfs_loader \
streamworks/flume \
$cmd
