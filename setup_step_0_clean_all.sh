#!/bin/sh

project_name='streamworks'

# stop project containers
for each in $(docker ps |grep $project_name |awk 'NF>1{print $NF}'); do
  cmd="docker stop $each"
  echo $cmd
  eval "$cmd"
done

# destroy project containers
for each in $(docker ps |grep $project_name |awk 'NF>1{print $NF}'); do
  cmd="docker rm $each"
  echo $cmd
  eval "$cmd"
done

# cleanup any dangling images
dangling_images=$(docker images -q --filter 'dangling=true')
if [ "$dangling_images" != '' ]; then
  cmd="docker rmi -f $dangling_images"
  echo $cmd
  eval "$cmd"
fi

# destroy project images
for each in $(docker images| grep $project_name| awk '{print $3;}'); do
  cmd="docker rmi -f $each"
  echo $cmd
  eval "$cmd"
done

rm -fr external/estreaming 
