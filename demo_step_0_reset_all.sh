#!/bin/sh

# remove project containers
for each in $(docker ps -a|grep $project_name |awk 'NF>1{print $NF}'); do
  cmd="docker stop $each"
  echo $cmd
  eval "$cmd"
done
