#!/bin/sh
cd $(dirname $0)

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
   echo "This script must be run as root" 1>&2
   exit 1
fi

eval 'hdfs' > /dev/null 2>&1
if [ $? -eq 127 ]; then
  echo -e "\e[7;107;91mHadoop does not appear to be installed. Check vagrant provisioning.\e[0m"
  exit 1
fi

eval ps aux |grep 'org.apache.hadoop.hdfs.server.datanode.[DataNode]'> /dev/null 2>&1
if [ $? == "0" ]; then
  echo -e "\e[7;44;96mStopping dfs...\e[0m"
  stop-dfs.sh
else
  echo -e "\e[7;107;91mHadoop 'dfs' is not running.\e[0m"
fi
