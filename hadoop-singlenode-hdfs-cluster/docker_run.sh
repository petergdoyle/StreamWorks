#!/bin/sh

dfs_cmd='start-dfs.sh'
bash_cmd='/bin/bash'
bootstrap_cmd='/etc/bootstrap.sh -d'
cmd=$bootstrap_cmd
mode='-d'
net_host="--net host"
networking='--net host'

docker run $mode -it \
-p 9000:9000 \
-v $PWD:/docker \
--name streamworks_hadoop_hdfs \
streamworks/hadoop \
$bash_cmd
