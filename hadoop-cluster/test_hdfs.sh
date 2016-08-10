#!/bin/sh

docker exec -ti streamworks_hadoop hdfs dfs -cat output/*

hdfs dfs -df
