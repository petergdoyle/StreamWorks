#!/bin/sh

project_name='streamworks'

# destroy project containers
for each in $(docker ps -a|grep $project_name |awk 'NF>1{print $NF}'); do
  echo -e 
  cmd="docker stop $each"
  echo $cmd
  eval "$cmd"
  cmd="docker rm $each"
  echo $cmd
  eval "$cmd"
done
