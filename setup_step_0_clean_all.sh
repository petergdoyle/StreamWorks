#!/bin/sh

project_name='streamworks'

# stop project containers
echo "Stopping $project_name Docker containers..."
for each in $(docker ps |grep $project_name |awk 'NF>1{print $NF}'); do
  cmd="docker stop $each"
  echo $cmd
  eval "$cmd"
done

# remove project containers
echo "Removing $project_name Docker containers..."
for each in $(docker ps -a|grep $project_name |awk 'NF>1{print $NF}'); do
  cmd="docker rm $each"
  echo $cmd
  eval "$cmd"
done

# destroy project images
echo "Rmoving $project_name Docker images..."
for each in $(docker images| grep $project_name| awk '{print $3;}'); do
  cmd="docker rmi -f $each"
  echo $cmd
  eval "$cmd"
done

# cleanup any dangling images
echo "Cleaning up any dangling Docker images..."
dangling_images=$(docker images -q --filter 'dangling=true')
if [ "$dangling_images" != '' ]; then
  cmd="docker rmi -f $dangling_images"
  echo $cmd
  eval "$cmd"
fi


echo "Removing temporary $project_name directories..."
rm -fr external/estreaming
rm -fr burrow/Burrow
rm -fr burrow/tmp
rm -fr burrow-stats/burrow-stats
