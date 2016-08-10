#!/bin/sh

dfs_cmd='start-dfs.sh'
bash_cmd='/bin/bash'
bootstrap_cmd='/etc/bootstrap.sh -d'
cmd=$bootstrap_cmd
mode='-d'
networking='--net host'

docker run $mode -it \
$networking \
-v $PWD:/docker \
-v /root/.ssh/:/root/.ssh/ \
--name streamworks_hadoop \
streamworks/hadoop \
$cmd
