#!/bin/sh

project_name='streamworks'

# stop project containers
for each in $(docker ps -a|grep $project_name |awk 'NF>1{print $NF}'); do
  cmd="docker start $each"
  echo $cmd
  eval "$cmd"
done
