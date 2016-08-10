#!/bin/sh

# cmd="docker exec -ti streamworks_hadoop hdfs dfs -df"
cmd="docker exec -ti streamworks_hadoop hdfs dfs -ls /splash"

echo "$cmd"
eval "$cmd"

echo "for more hdfs dfs commands see:
http://hortonworks.com/hadoop-tutorial/using-commandline-manage-files-hdfs/#create-a-directory-in-hdfs-upload-a-file-and-list-contents"
