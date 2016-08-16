#!/bin/sh

cmd="docker exec -ti streamworks_hadoop hdfs dfs -mkdir /splash"

export JAVA_HOME='/usr/java/default'
export HADOOP_HOME='/usr/hadoop/default'
export PATH=$HADOOP_INSTALL/bin:$HADOOP_INSTALL/sbin:$PATH
export HADOOP_HOME=$HADOOP_HOME
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_INSTALL
export HADOOP_YARN_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_HOME=$HADOOP_INSTALL
export PATH=$HADOOP_INSTALL/bin:$HADOOP_INSTALL/sbin:$PATH
export CLASSPATH=$HADOOP_HOME/lib

if [ "$(id -u)" != "0" ]; then
   echo -e "\e[7;107;91mThis script must be run as root\e[0m" 1>&2
   exit 1
fi

eval 'hdfs' > /dev/null 2>&1
if [ $? -eq 127 ]; then
  echo -e "\e[7;107;91mHadoop does not appear to be installed. Check vagrant provisioning.\e[0m"
  exit 1
fi

eval 'hdfs dfs -ls /splash'> /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo -e "The demo hdfs folder /splash does not exist. Creating now..."
  hdfs dfs -mkdir /splash
else
  echo -e "The demo hdfs folder /splash already exists."
fi

out=$(hdfs dfs -ls /)
echo $out
