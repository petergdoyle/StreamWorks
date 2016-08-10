#!/bin/sh

cmd="docker exec -ti streamworks_hadoop hdfs dfs -mkdir /splash"

echo "$cmd"
eval "$cmd"
